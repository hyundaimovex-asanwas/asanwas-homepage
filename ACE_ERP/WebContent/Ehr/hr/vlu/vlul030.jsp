<!--
*****************************************************
* @source       : vlul030.jsp
* @description  : �����������Է� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/11/11      ���ϳ�        �����ۼ�.
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
<title>�����������Է� �μ���(vlul030)</title>
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

          var GUBUN 	= "3";

			  //����
		      dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul030.cmd.VLUL030CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST.reset();
			  //fnc_Reset('q');

			  //�����
		      dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul030.cmd.VLUL030CMD&S_MODE=SHR_03&REG_YM_SHR="+REG_YM_SHR+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST2.reset();
			  //fnc_Reset('q');


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

  //   var TOTAL_SCR = 0;


  			if ((dsT_EV_ABLRST.countrow<1) || (dsT_EV_ABLRST2.countrow<1)){
  				alert ("������ ������ �����ϴ�.");
  			}else {
  					if (confirm("�����Ͻðڽ��ϱ�?")) {

  							for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){

  							trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";

  		        			trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
  		        			trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul030.cmd.VLUL030CMD"
							  	  		        				+ "&S_MODE=SAV_01"
								  	  							+ "&REG_YM_SHR="+REG_YM_SHR;
								  	  					//		+ "&TOTAL_SCR="+TOTAL_SCR;


  	  	  	  		    }

	  						trT_EV_ABLRST.post();


	  							for ( i=1;i<=dsT_EV_ABLRST2.countrow;i++){

	  							trT_EV_ABLRST2.KeyValue = "tr01(I:dsT_EV_ABLRST2=dsT_EV_ABLRST2)";

	  		        			trT_EV_ABLRST2.KeyValue = "tr01(I:dsT_EV_ABLRST2=dsT_EV_ABLRST2)";
	  		        			trT_EV_ABLRST2.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul030.cmd.VLUL030CMD"
								  	  		        				+ "&S_MODE=SAV_02"
									  	  							+ "&REG_YM_SHR="+REG_YM_SHR;
									  	  					//		+ "&TOTAL_SCR="+TOTAL_SCR;

							  //	trT_EV_ABLRST.reset();
							//    prompt(this,trT_EV_ABLRST2.action);
						//	    prompt(this,trT_EV_ABLRST2.dataID);
							//	prompt(this,trT_EV_ABLRST2.text);
							//	alert(REG_YM_SHR);

	  	  	  	  		    }
						//	prompt(this,dsT_EV_RQSCORE.dataID);
						//	prompt(this,dsT_EV_RQSCORE.text);

	  						trT_EV_ABLRST2.post();

	  						fnc_SearchList();

  			}
         }
      }




		/******************************************************************************
			Description : ����� ���� Grid �ʱ�ȭ
			parameter - q : query��   r -reset �ʱ�ȭ
		******************************************************************************/
		function fnc_Reset(p){
/*
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
*/
		}

		/******************************************************************************
			Description : Check
		******************************************************************************/
        function fnc_Chk() {

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


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

		document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

		document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);
		//document.getElementById("txtREG_YM_SHR").value = '2013-06';
		//document.getElementById("txtENOH_NO_SHR").value="<%=eno_no%>";
//		document.getElementById("txtENOH_NM_SHR").value="<%=eno_nm%>";


        cfStyleGrid(form1.grdT_EV_ABLRST,0,"true","false");      // Grid Style ����
        cfStyleGrid(form1.grdT_EV_ABLRST2,0,"true","false");      // Grid Style ����


		<%
		    //�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
		    if(!(box.getString("SESSION_ENONO").equals("6060002") || box.getString("SESSION_ENONO").equals("6080002") || box.getString("SESSION_ENONO").equals("1990071") || box.getString("SESSION_ENONO").equals("2070020") || box.getString("SESSION_ENONO").equals("2020008"))) {
		%>
		     //       fnc_ChangeStateElement(false, "txtENOH_NO_SHR");
		    //        fnc_ChangeStateElement(false, "txtENOH_NM_SHR");
		            fnc_ChangeStateElement(false, "ImgEnoNo");
		<%
		    }
		%>

		fnc_SearchList();


        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /******************************
         * 16. �������       		   *
         ******************************/
        function fnc_Correct(){


		}



		/******************************************************************************
			Description : ���������ȸ
		******************************************************************************/
	/*
		function fnc_Grid_Onclick(gubun,row){

		    GSTR_YYYYMM ="";
			GSTR_EMPNO = "";
			GSTR_GRPCD = "";
			GSTR_JOBGRPH = "";
			GSTR_EVASEQ = "";
			GSTR_PAYGRD = "";

			if(gubun=="1"){
				GSTR_YYYYMM	 = dsT_EV_ABLRST.namevalue(row,"EVAYM");
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

		} */

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

    <Object ID="dsT_EV_CORCAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Object ID ="trT_EV_ABLRST2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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

    <!--
    <Script For=grdT_EV_ABLRST Event="OnClick(row,col)">
    	fnc_Grid_Onclick('1',row);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnClick(row,col)">
    	fnc_Grid_Onclick('5',row);
    </Script>
-->
    <Script For=grdT_EV_ABLRST Event="OnDblClick(row,col)">
    //	fnc_Grid_Dblclick(row,col);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnDblClick(row,col)">
    //	fnc_Grid_Dblclick2(row,col);
    </Script>

    <!--
    <Script For=grdT_EV_ABLRST2 Event="OnClick(row,col)">
    	fnc_Grid_Onclick('1',row);
    </Script>
-->
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_CORCAL Event="OnLoadCompleted(iCount)">
		alert("��������� ���ƽ��ϴ�");
		fnc_SearchList();
    </Script>

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
        //fnc_SearchList();
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����������Է�_�μ���</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�����������Է�_�μ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOver.gif" name="Image2"  border="0" align="absmiddle" onClick="fnc_Save()"></a>&nbsp;&nbsp;
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
	                            <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
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
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:350px;">
                                <param name="DataID"                 		value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="SortView"               	value="Left">
                                <param name="VIEWSUMMARY"          value=1>
                                <param name="AutoReSizing"          	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="Format"                 		value="
                                    <C> id='DEPTNM'    	width=80  	name='����:�Ҽ�'   align=left      edit=none sumbgcolor=#89add6</C>
                                    <C> id='PAYGRDNM'   	width=40  	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText=''</C>
                                    <C> id='EMPNMK'   		width=60  	name='�ǰ����'   	align=center    edit=none sumbgcolor=#89add6 </C>
                                    <C> id='EMPNO'   		width=60  	name=' ���'   	align=center    edit=none sumbgcolor=#89add6 </C>
                                    <C> id='SCR1'    			width=60   	name='����'      	align=center   sumbgcolor=#89add6 SumText={Round(sum(SCR1),2)}  </C>
                                    <C> id='AVG1'   		width=60  	name='����'   		align=center     sumbgcolor=#89add6 SumText={Round(avg(AVG1),2)} </C>
                                    <C> id='ASSES'    		width=45   	name='��'      	align=center    sumbgcolor=#89add6 show=false</C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>

                        <td>&nbsp;
                        </td>

                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:350px;">
                                <param name="DataID"                 		value="dsT_EV_ABLRST2">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="SortView"               	value="Left">
                                <param name="VIEWSUMMARY"          value=1>
                                <param name="AutoReSizing"           	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="Format"                 		value="
                                    <C> id='DEPTNM'    	width=80  	name='�����:�Ҽ�'  align=left      edit=none sumbgcolor=#89add6</C>
                                    <C> id='PAYGRDNM'   	width=40  	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText=''</C>
                                    <C> id='EMPNMK'   		width=60  	name='�ǰ����'   	align=center    edit=none sumbgcolor=#89add6</C>
                                    <C> id='EMPNO'   		width=60  	name=' ���'   	align=center    edit=none sumbgcolor=#89add6 </C>
                                    <C> id='SCR1'    			width=60   	name='����'      	align=center     sumbgcolor=#89add6 SumText={Round(sum(SCR1),2)} </C>
                                    <C> id='AVG1'   		width=60  	name='����'   		align=center    sumbgcolor=#89add6 SumText={Round(avg(AVG1),2)} </C>
                                    <C> id='ASSES'    		width=45   	name='��'      	align=center    sumbgcolor=#89add6 show=false</C>
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


