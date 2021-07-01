<!--
*****************************************************
* @source       : vluk070.jsp
* @description  : ���������(�μ���) PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/05/23      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���������(�μ���)(vluk070)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
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

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

          //�˻����� 4����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;        //�Ҽ�
          var JOB_CD_SHR = document.form1.txtJOB_CD_SHR.value;        //����
          var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;        //���

		  dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk070.cmd.VLUK070CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
		  dsT_EV_ABLRST.reset();

        }

        function fnc_SearchList2() {

          //�˻����� 6����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;        //�Ҽ�
          var JOB_CD_SHR = document.form1.txtJOB_CD_SHR.value;        //����
          var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;        //���
          var ENO_NOH = document.form1.txtENO_NO.value;        		  //�����
          var EVA_SEQ = document.form1.cmbEVA_SEQ.value;        	  //����

		  dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk070.cmd.VLUK070CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&ENO_NOH="+ENO_NOH+"&EVA_SEQ="+EVA_SEQ;
		  dsT_EV_ABLRST2.reset();

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

			if (dsT_EV_ABLRST2.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {
				if(fnc_Chk()){

					if(fnc_Chk2()){

					  if (confirm("�����Ͻðڽ��ϱ�?")) {

			            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST2=dsT_EV_ABLRST2)";
			            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk070.cmd.VLUK070CMD&S_MODE=SAV";
			            trT_EV_ABLRST.post();
						//	ln_Query2();
						}
					}
				}
        	}
        }

		/******************************************************************************
			Description : ����� ���� ����� üũ
		    dsT_EV_ABLRST2.namevalue(i, "CHKOUT")=="T"  : ����� ����
		    UserStatus(i)=2  -- Delete
		******************************************************************************/

		function fnc_Chk(){

			for(i=1; i<=dsT_EV_ABLRST2.countrow;i++){
				if (dsT_EV_ABLRST2.namevalue(i, "CHKOUT")=="T") {
					dsT_EV_ABLRST2.UserStatus(i)=2;
				}
			}
			return true;
		}

		/******************************************************************************
			Description : ����� ������ �߻�
		******************************************************************************/
		function fnc_Chk2(){

			for(i=1; i<=dsT_EV_ABLRST2.countrow;i++){
				for ( j=1;j<=dsT_EV_ABLRST2.countrow;j++){
					if(i!=j){
						if ((dsT_EV_ABLRST2.namevalue(i,"EMPNO"))==(dsT_EV_ABLRST2.namevalue(j,"EMPNO")) && (dsT_EV_ABLRST2.namevalue(i,"EVASEQ"))==(dsT_EV_ABLRST2.namevalue(j,"EVASEQ"))){
								alert("���� �ǰ������  ����� ������ �����մϴ�.");
								return false;
								break;
						}
					}
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

            form1.grdT_EV_ABLRST.GridToExcel("���������(�μ���)", '', 225);

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

            f.txtJOB_CD_SHR.value = '';
            f.txtJOB_NM_SHR.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM_SHR.value = '';
            f.txtENO_NO.value = '';
            f.txtENO_NM.value = '';
            f.cmbEVA_SEQ.value = '';

            dsT_EV_ABLRST.ClearData();
            dsT_EV_ABLRST2.ClearData();

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

		cfStyleGrid5(form1.grdT_EV_ABLRST,15,"true","right");      // Grid Style ����
        cfStyleGrid(form1.grdT_EV_ABLRST2,15,"true","false");      // Grid Style ����


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
        function fnc_Reset(p) {

			if(p=="r"){
				if (dsT_EV_ABLRST2.countrow>=1){
					dsT_EV_ABLRST2.ClearData();
		            document.form1.txtJOB_CD_SHR.value = '';
		            document.form1.txtJOB_NM_SHR.value = '';
		            document.form1.txtDPT_CD_SHR.value = '';
		            document.form1.txtDPT_NM_SHR.value = '';
		            document.form1.txtENO_NO_SHR.value = '';
		            document.form1.txtENO_NM_SHR.value = '';
		            document.form1.txtENO_NO.value = '';
		            document.form1.txtENO_NM.value = '';
		            document.form1.cmbEVA_SEQ.value = '';
				}else{
		            document.form1.txtJOB_CD_SHR.value = '';
		            document.form1.txtJOB_NM_SHR.value = '';
		            document.form1.txtDPT_CD_SHR.value = '';
		            document.form1.txtDPT_NM_SHR.value = '';
		            document.form1.txtENO_NO_SHR.value = '';
		            document.form1.txtENO_NM_SHR.value = '';
		            document.form1.txtENO_NO.value = '';
		            document.form1.txtENO_NM.value = '';
		            document.form1.cmbEVA_SEQ.value = '';
					alert("�ʱ�ȭ �� �����Ͱ� �������� �ʽ��ϴ�.");
				}
			}else if(p=="q"){
				if (dsT_EV_ABLRST2.countrow>=1) dsT_EV_ABLRST2.ClearData();
			}

        }

        /******************************
         * 17. ����� ����             *
         ******************************/
        function fnc_Appoint() {

					if (dsT_EV_ABLRST.countrow > 0 ) {

						if  (fnc_Appoint_Chk()){

							for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){

								if (dsT_EV_ABLRST.namevalue(i,"CHK") =="T"){

												fnc_Header_create();

												dsT_EV_ABLRST2.addrow();

												j = dsT_EV_ABLRST2.countrow;

												dsT_EV_ABLRST2.namevalue(j,"CHKOUT") = "F";
												dsT_EV_ABLRST2.namevalue(j,"EVAYM") =  document.form1.txtREG_YM_SHR.value.replace("-","");
												dsT_EV_ABLRST2.namevalue(j,"EMPNOH") = document.form1.txtENO_NO.value ;        			//�����
												dsT_EV_ABLRST2.namevalue(j,"EMPNMKH") = document.form1.txtENO_NM.value ;       			//����ڸ�
												dsT_EV_ABLRST2.namevalue(j,"EVASEQ"  ) = document.getElementById("cmbEVA_SEQ").value;   //����
												dsT_EV_ABLRST2.namevalue(j,"EMPNO") = dsT_EV_ABLRST.namevalue(i,"EMPNO") ;   			//�ǰ����
												dsT_EV_ABLRST2.namevalue(j,"EMPNMK") = dsT_EV_ABLRST.namevalue(i,"EMPNMK") ; 			//�ǰ���ڸ�

							                    //���������
												dsT_EV_ABLRST2.namevalue(j,"DEPTCD") = document.form1.txtDPT_CD.value ; 			//�Ҽ��ڵ�
												dsT_EV_ABLRST2.namevalue(j,"DEPTNM") = document.form1.txtDPT_NM.value ; 			//�ҼӸ�
												dsT_EV_ABLRST2.namevalue(j,"PAYGRD") = document.form1.txtJOB_CD.value ; 			//�����ڵ�
												dsT_EV_ABLRST2.namevalue(j,"PAYGRDNM") = document.form1.txtJOB_NM.value ; 			//������
												//dsT_EV_ABLRST2.namevalue(j,"STRTDT") = txt_strtdt.value; 			//�Ի���

												fnc_Evaseq(i, document.getElementById("cmbEVA_SEQ").value, document.form1.txtENO_NM.value);

								}
							} //for
						}

					}else{
						alert("�����Ͱ� �������� �ʽ��ϴ�");
					}

        }

        /******************************
         * 18. ����� ���� üũ       *
         ******************************/

		function fnc_Appoint_Chk(){

			var seq1="",  seq2="",  seq3="",  seq4="",  seq5="" ,seq6="",seq7="",seq8="",seq9="",seq10="" ;
  			var seq11="", seq12="", seq13="", seq14="", seq15="";

			var seq_val = document.getElementById("cmbEVA_SEQ").value;

			for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){
				if (dsT_EV_ABLRST.namevalue(i,"CHK") =="T")
					cntchk = "Y";
			}

			i= 0 ;

			if (cntchk =="N"){
				alert("���õ� �ǰ���ڰ� �����ϴ�.");
				return;
			}

			cntchk = "N";

			if (document.form1.txtENO_NO.value == "" &&  document.form1.txtENO_NM.value == "") {
				alert( "����ڰ� �������� �ʽ��ϴ�.")
				return false;
			}

			if (seq_val=="0") {
				alert( "������ �������� �ʽ��ϴ�.")
				return false;
			}

			for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){

				if ( dsT_EV_ABLRST.namevalue(i,"CHK") =="T"){

					if(dsT_EV_ABLRST.namevalue(i,"EMPNO") == document.form1.txtENO_NO.value){

						alert("�ǰ���ڿ� ����ڰ� �����մϴ�");

						return false ;

					}else{

						if  (dsT_EV_ABLRST2.countrow>0 ){

							for ( j=1;j<=dsT_EV_ABLRST2.countrow;j++){

								if((dsT_EV_ABLRST2.namevalue(j,"EVASEQ")==document.getElementById("cmbEVA_SEQ").value) &&   (dsT_EV_ABLRST2.namevalue(j,"EMPNO")==dsT_EV_ABLRST.namevalue(i,"EMPNO"))) {

									alert("���� �ǰ������  ����� ������ �����մϴ�.");

									return false;

									break;

								 }//if

								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK1")!="")) seq1="1";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK2")!="")) seq2="2";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK3")!="")) seq3="3";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK4")!="")) seq4="4";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK5")!="")) seq1="5";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK6")!="")) seq2="6";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK7")!="")) seq3="7";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK8")!="")) seq4="8";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK9")!="")) seq1="9";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK10")!="")) seq2="10";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK11")!="")) seq3="11";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK12")!="")) seq4="12";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK13")!="")) seq1="13";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK14")!="")) seq2="14";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK15")!="")) seq3="15";

								if ((seq1==seq_val)||(seq2==seq_val)||(seq3==seq_val)||(seq4==seq_val)||(seq5==seq_val)||(seq6==seq_val)||(seq7==seq_val)
								||(seq8==seq_val)||(seq9==seq_val)||(seq10==seq_val)||(seq11==seq_val)||(seq12==seq_val)||(seq13==seq_val)||(seq14==seq_val)){
									alert("���� ������ �����մϴ�.");
									return false ;

								}
							}//for
						}else if(dsT_EV_ABLRST2.countrow<=0){

								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK1")!="")) seq1="1";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK2")!="")) seq2="2";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK3")!="")) seq3="3";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK4")!="")) seq4="4";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK5")!="")) seq1="5";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK6")!="")) seq2="6";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK7")!="")) seq3="7";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK8")!="")) seq4="8";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK9")!="")) seq1="9";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK10")!="")) seq2="10";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK11")!="")) seq3="11";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK12")!="")) seq4="12";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK13")!="")) seq1="13";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK14")!="")) seq2="14";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK15")!="")) seq3="15";

								if ((seq1==seq_val)||(seq2==seq_val)||(seq3==seq_val)||(seq4==seq_val)||(seq5==seq_val)||(seq6==seq_val)||(seq7==seq_val)
								||(seq8==seq_val)||(seq9==seq_val)||(seq10==seq_val)||(seq11==seq_val)||(seq12==seq_val)||(seq13==seq_val)||(seq14==seq_val)){

									alert("���� ������ �����մϴ�.");
									return false ;
							}
						}
					}
				}
			}

			if (document.form1.txtENO_NO.value=="") {
				alert( "������ �������� �ʽ��ϴ�.")
				return false;
			}
			return true;
		}

        /******************************
         * 19. ����Ÿ�� ��� ����       *
         ******************************/

		function fnc_Header_create(){

			if (dsT_EV_ABLRST2.countrow<1){
				var Header1= "CHKOUT:STRING,EVAYM:STRING, EMPNOH:STRING,EMPNMKH:STRING,EMPNO:STRING,EMPNMK:STRING,EVASEQ:DECIMAL,DEPTCD:STRING,DEPTNM:STRING,STRTDT:STRING, PAYGRD:STRING,PAYGRDNM:STRING, ODLEMPNOH:STRING, OLDEVASEQ:DECIMAL";
				dsT_EV_ABLRST2.SetDataHeader(Header1);
			}
		}

         /******************************
         * 19. �ǰ���� ���� �ڵ� ���� *
         ******************************/

		function fnc_Evaseq(i,seq, name){

			if (seq == "1" ) {
				dsT_EV_ABLRST.namevalue(i,"EMPNMK1") = name;
			}else if (seq == "2" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK2") = name;
			}else if (seq == "3" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK3") = name;
		    }else if (seq == "4" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK4") = name;
			}else if (seq == "5" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK5") = name;
			}else if (seq == "6" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK6") = name;
			}else if (seq == "7" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK7") = name;
		    }else if (seq == "8" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK8") = name;
			}else if (seq == "9" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK9") = name;
		    }else if (seq == "10" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK10") = name;
		    }else if (seq == "11" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK11") = name;
			}else if (seq == "12" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK12") = name;
		    }else if (seq == "13" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK13") = name;
			}else if (seq == "14" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK14") = name;
			}else if (seq == "15" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK15") = name;
		  }

		}


       /***********************
       * �����ȸ�� �˾� *
       **********************/
        function fnc_EmplPopp() {
			var obj = new String();
            obj.shr_kind = "SHR_03";
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

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ABLRST)        |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_EV_ABLRST event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "CHK" && dsT_EV_ABLRST.CountRow > 0) {
            for(var i=1; i<=dsT_EV_ABLRST.CountRow; i++) {
                if(dsT_EV_ABLRST.NameString(i, "CHK") == "F") {
                    dsT_EV_ABLRST.NameString(i, "CHK") = "T";
                } else if(dsT_EV_ABLRST.NameString(i, "CHK") == "T") {
                    dsT_EV_ABLRST.NameString(i, "CHK") = "F";
                }
            }
        }
    </script>


	<!-- ������������� ����-->
	<script language=JavaScript for=grdT_EV_ABLRST2 event=OnClick(row,colid)>

		if (dsT_EV_ABLRST2.countrow<1) {
			return;
		}

		for(i=1;i<=dsT_EV_ABLRST2.countrow;i++){

			if(dsT_EV_ABLRST2.namevalue(i,"CHKOUT")=="T"){

				for(j=1;j<=dsT_EV_ABLRST.countrow;j++){

					if((dsT_EV_ABLRST2.namevalue(i,"EVAYM")==dsT_EV_ABLRST.namevalue(j,"EVAYM")) && (dsT_EV_ABLRST2.namevalue(i,"EMPNO")==dsT_EV_ABLRST.namevalue(j,"EMPNO"))){

						fnc_Evaseq(j, dsT_EV_ABLRST2.namevalue(i,"EVASEQ"), '');

						break;

				    }
				}
			}
		}
	</script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_SearchList2();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
            cfErrorMsg(this);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���������(�μ���)</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���������(�μ���)</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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

	                            <col width="70"></col>
	                            <col width="60"></col>
	                            <col width="50"></col>
	                            <col width="130"></col>
	                            <col width="50"></col>
	                            <col width="130"></col>
	                            <col width="50"></col>
	                            <col width="*"></col>

                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
	                            <td class="searchState" align="right">�ҼӺ�</td>
	                            <td class="padding2423" align="left">
	                                <input id="txtDPT_CD_SHR" size="3" maxlength="4">
	                                <input id="txtDPT_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
	                                <img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
	                            </td>
	                            <td class="searchState" align="right">������</td>
	                            <td class="padding2423" align="left">
	                                <input id="txtJOB_CD_SHR" size="3" maxlength="4">
	                                <input id="txtJOB_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)">
	                                <img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
	                            </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:395px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='CHK'     		width=45   	name='����'  Edit=True  		align=center    EditStyle=CheckBox  Pointer=Hand  Edit={IF(CHK='','false','true')}  HeadCheckShow=true </FC>
                                    <FG> name='�ǰ����'    HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <FC> id='EMPNO'    	width=50   	name='���'   		align=left    	edit=none sort=true</FC>
	                                    <FC> id='EMPNMK'   	width=50  	name='����'  		align=left      edit=none sort=true</FC>
	                                </FG>
                                    <FC> id='DEPTNM'    	width=100  	name='�Ҽ�'     			align=left      edit=none sort=true</FC>
                                    <C> id='EMPNMK1'   		width=45  	name='1��;�����'      	align=center    edit=none </C>
                                    <C> id='EMPNMK2'   		width=45  	name='2��;�����'   		align=center    edit=none </C>
                                    <C> id='EMPNMK3'    	width=45   	name='3��;�����'      	align=center    edit=none </C>
                                    <C> id='EMPNMK4'   		width=45  	name='4��;�����'      	align=center    edit=none </C>
                                    <C> id='EMPNMK5'   		width=45  	name='5��;�����'   		align=center    edit=none </C>
                                    <C> id='EMPNMK6'    	width=45   	name='6��;�����'      	align=center    edit=none </C>
                                    <C> id='EMPNMK7'   		width=45  	name='7��;�����'      	align=center    edit=none </C>
                                    <C> id='EMPNMK8'   		width=45  	name='8��;�����'   		align=center    edit=none </C>
                                    <C> id='EMPNMK9'    	width=45   	name='9��;�����'      	align=center    edit=none </C>
                                    <C> id='EMPNMK10'   	width=45  	name='10��;�����'      align=center    edit=none </C>
                                    <C> id='EMPNMK11'   	width=45  	name='11��;�����'   		align=center    edit=none </C>
                                    <C> id='EMPNMK12'    	width=45   	name='12��;�����'      align=center    edit=none </C>
                                    <C> id='EMPNMK13'   	width=45  	name='13��;�����'      align=center    edit=none </C>
                                    <C> id='EMPNMK14'   	width=45  	name='14��;�����'  	 	align=center    edit=none </C>
                                    <C> id='EMPNMK15'    	width=45   	name='15��;�����'      align=center    edit=none </C>

                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
            <td width=3>
            </td>



            <td class="paddingTop3">
                <table border="1" cellspacing="0" cellpadding="0">

                                <colgroup>

	                            <col width="50"></col>
	                            <col width="150"></col>
	                            <col width="50"></col>
	                            <col width="150"></col>

                    </colgroup>
					<tr>
						<td width=50  class="creamBold" border="1"><nobr>&nbsp;���������</nobr></td>
						<td align=right  colspan=3><nobr>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_Clear.gif',1)"><img src="/images/button/btn_Clear.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reset('r')"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_Set.gif',1)"><img src="/images/button/btn_Set.gif" name="Image2" width="50" height="20" border="0" align="absmiddle" onClick="fnc_Appoint()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList2()"></a>

					</tr>
					<tr>
						<td width=50  class="creamBold"><nobr>&nbsp;�����&nbsp;</nobr></td>
						<td width=150>
							<input id="txtENO_NO" name="txtENO_NO" size="7" maxlength="7" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO','txtENO_NM');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO','txtENO_NM')" style="ime-mode:disabled">
							<input id="txtENO_NM" name="txtENO_NM" size="6" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO');fnc_SearchList();">
							<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPopp();"></a>
							<input type="hidden"  id="txtDPT_CD">
							<input type="hidden"  id="txtDPT_NM">
							<input type="hidden"  id="txtJOB_CD">
							<input type="hidden"  id="txtJOB_NM">
						<td width=50 class="creamBold"><nobr>&nbsp;����</nobr></td>
						<td width=150>
								<select id="cmbEVA_SEQ" style="width:100">
									<option value=""> </option>
									<option value="1">1��</option>
									<option value="2">2��</option>
									<option value="3">3��</option>
									<option value="4">4��</option>
									<option value="5">5��</option>
									<option value="6">6��</option>
									<option value="7">7��</option>
									<option value="8">8��</option>
									<option value="9">9��</option>
									<option value="10">10��</option>
									<option value="11">11��</option>
									<option value="12">12��</option>
									<option value="13">13��</option>
									<option value="14">14��</option>
									<option value="15">15��</option>
								</select>
						</td>
					</tr>


                    <tr align="center">
                        <td colspan=4>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:340px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST2">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC>id='CHKOUT'     		width=30   	name='����'    		align=center    EditStyle=CheckBox  </FC>
                                    <FG>name='�ǰ����'    	HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <FC> id='EMPNO'    		width=50   	name='���'   		align=left    	edit=none </FC>
	                                    <FC> id='EMPNMK'   		width=50  	name='����'  		align=left      edit=none </FC>
	                                </FG>
		                            <FG>name='�����'    	HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <FC>id='EMPNMKH'    	width=50  	name='����'     	align=left      edit=none </FC>
	                                    <C>id='EVASEQ'   		width=50  	name='����'      	align=center    EditStyle=Combo  Data='1:1��,2:2��,3:3��'</C>
	                                    <C>id='DEPTNM'   		width=80  	name='�Ҽ�'   		align=left    	edit=none </C>
	                                    <C>id='PAYGRDNM'    	width=50   	name='����'      	align=center    edit=none </C>
                                    </FG>
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


