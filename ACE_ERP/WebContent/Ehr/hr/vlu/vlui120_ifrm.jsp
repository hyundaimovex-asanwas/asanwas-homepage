<!--
*****************************************************
* @source       : vlui100.jsp
* @description  : �����Ű��ۼ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����Ű��ۼ�(vlui120)</title>
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
        var REG_YM_SHR = window.external.GetFrame(window).REG_YM_SHR;
		var gs_format="";
		var gs_seq;
        var GUBUN   = "";
		var gs_gb="";
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

	            //�˻����� 2����
	            var REG_YM_SHR = parent.document.form1.txtREG_YM_SHR.value;        	//�ش�⵵
				var ENO_NO = parent.document.form1.txtENO_NO_SHR.value;				//���

				fnc_Row_Clear(1);

				trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_HWORKDTL=dsT_EV_HWORKDTL)";

				trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui120.cmd.VLUI120CMD"
	                                   + "&S_MODE=SHR_01"
	                                   + "&REG_YM_SHR="+REG_YM_SHR
	                                   + "&ENO_NO="+ENO_NO;

				trT_EV_ABLRST.post();


		    	var gs_evayy = REG_YM_SHR.substring(0,4);
		    	var gs_evamm = REG_YM_SHR.substring(4,6);

				gs_gb="";

				if (gs_evamm>="01"&&gs_evamm<="06"){
					gs_gb = gs_evayy+"�� ��ݱ�"
				}else{
		      		gs_gb = gs_evayy+"�� �Ϲݱ�"
				}


			    if(dsT_EV_HWORKDTL.namevalue(1,"WORKGB")==undefined&&dsT_EV_HWORKDTL.namevalue(1,"WKCONT")==undefined&&dsT_EV_HWORKDTL.namevalue(1,"IMPORT")==undefined){

						txt_21.value="�ؾ����׸�";
			            txt_31.value="��2012�� �ֿ���� �� ����(����) ��� \n (�ۼ��� ���κ� ���������, ����������ȹ���� �����Ͽ� �ۼ�)";
						txt_41.value="����ġ�� �Ѱ谡 100% �ǵ��� ����"

						fnc_SetDataHeader(2);

			  			dsT_EV_HWORKDTL.Addrow();

		    			var gs_evayymm = REG_YM_SHR.substring(0,4)+REG_YM_SHR.substring(5,7);

						dsT_EV_HWORKDTL.namevalue(1,"EVAYM")  = gs_evayymm;
						dsT_EV_HWORKDTL.namevalue(1,"EMPNO")  = parent.document.form1.txtENO_NO_SHR.value;
						dsT_EV_HWORKDTL.namevalue(1,"SEQ2")   = eval("txt_1"+i).value;
						dsT_EV_HWORKDTL.namevalue(1,"WORKGB") = eval("txt_2"+i).value;
						dsT_EV_HWORKDTL.namevalue(1,"WKCONT") = eval("txt_3"+i).value;
						dsT_EV_HWORKDTL.namevalue(1,"IMPORT") = eval("txt_4"+i).value;
						dsT_EV_HWORKDTL.namevalue(1,"REMARK") = eval("txt_5"+i).value;

					}

        	}

			/******************************************************************************
				Description : DTL ȭ�� DISPLAY
			  parameter   :
			******************************************************************************/
			function fnc_SetFormat(i){

				  	gs_format +="<table  cellpadding=0 cellspacing=0 style=width:800px;height:30px;font-size:9pt;background-color:#ffffff;>"
					gs_format +="	<tr>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		<textarea id=txt_1"+i+"   style=width:40px;height:150px;overflow:auto;font-size:30pt;text-align:center;vertical-align:center; readOnly></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_2"+i+" style=width:82px;height:150px;overflow:auto;ime-mode:active; maxlength=50 onBlur=bytelength(this,this.value,100);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_3"+i+" style=width:555px;height:150px;overflow:auto;ime-mode:active; maxlength=1000 onBlur=bytelength(this,this.value,1500);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_4"+i+" style=width:62px;height:150px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,100);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_5"+i+" style=width:60px;height:150px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,100);></textarea>"
					gs_format +="		</td>"
					gs_format +="	</tr>"
					gs_format +="</table>";

			}


			/******************************************************************************************
				Descrition : �Է°� üũ (db2 �Է½� �Է°� 2byte ��ȯ�� �ڸ��� üũ)
			******************************************************************************************/
			function bytelength(fe,bstr,mx) {

				var xx = "";
				var yy = "";
				var len = bstr.length;

				for (var i=0; i<bstr.length; i++) {
					xx = bstr.substr(i,1).charCodeAt(0);
					if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0);

					if (i==0) {
						if (xx>127) {	len++;len++; }
					} else {
						if (yy!="") {
							if (yy>127) { len++; }
							else { if (xx>127) { len++;len++; } }
						}
					}
				}

				if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;

				// Ŭ��� �޽��� �Ѹ���
				if (mx < len){
					alert('�Է��� ���� �� �߸��� �ֽ��ϴ�.\n�ٽ� �Է��Ͽ� �ֽʽÿ�');
					fe.focus();
					fe.select();
				}

				return len;
			}


			/******************************************************************************
				Description : ����Ÿ�� ==> ȭ�鵥��Ÿ ���� (DTL)
			******************************************************************************/
			function fnc_Display(i){

					eval("txt_1"+i).value=dsT_EV_HWORKDTL.namevalue(i,"SEQ2");
					eval("txt_2"+i).value=dsT_EV_HWORKDTL.namevalue(i,"WORKGB");
					eval("txt_3"+i).value=dsT_EV_HWORKDTL.namevalue(i,"WKCONT");
					eval("txt_4"+i).value=dsT_EV_HWORKDTL.namevalue(i,"IMPORT");
					eval("txt_5"+i).value=dsT_EV_HWORKDTL.namevalue(i,"REMARK");

			}

			/******************************************************************************
				Description : �����
				parameter : 1 - 1�ุ ���ܵΰ� ����
				            2 - ��� ������ �ʱ� �� �� �߰�
			******************************************************************************/
			function fnc_Row_Clear(gbn){

					if(gbn==1){
						for(i=gs_seq;i>1;i--){
							table_1.deleteRow();
						}
						gs_seq=1;
					}else if(gbn==2){
						for(i=gs_seq;i>=1;i--){
							table_1.deleteRow();
						}
						fnc_Initial();
					}
			}

			/******************************************************************************
				Description : �ʱ�
			******************************************************************************/

			function fnc_Initial(){

					gs_seq=1;

					gs_format ="";

					dsT_EV_HWORKDTL.deleteall();

					var oRow = table_1.insertRow();

				  	var oCell = oRow.insertCell();

					fnc_SetFormat(gs_seq);

				  	oCell.innerHTML = gs_format;

					txt_11.value=1;

					fnc_SetDataHeader();

					dsT_EV_HWORKDTL.addrow();
			}

			/******************************************************************************
				Description : ���߰�
			******************************************************************************/
			function fnc_Add(){

			     fnc_SetDataHeader(2);

			     gs_seq+=1;

			     gs_format="";

				 fnc_SetFormat(gs_seq);

				 var oRow = table_1.insertRow();

				 var oCell = oRow.insertCell();

				 oCell.innerHTML = gs_format;

				 eval("txt_1"+gs_seq).value=gs_seq;

				 dsT_EV_HWORKDTL.addrow();

				 fnc_Data(gs_seq);

			}

			/******************************************************************************
				Description : ȭ�� ����Ÿ ==> ����Ÿ�� ���� (DTL)
			******************************************************************************/
			function fnc_Data(i){

	            var REG_YM_SHR = parent.document.form1.txtREG_YM_SHR.value;        	//�ش�⵵
		    	var gs_evaym = REG_YM_SHR.substring(0,4)+REG_YM_SHR.substring(5,7);

				dsT_EV_HWORKDTL.namevalue(i,"EVAYM")  = gs_evaym;
				dsT_EV_HWORKDTL.namevalue(i,"EMPNO")  = parent.document.form1.txtENO_NO_SHR.value;
				dsT_EV_HWORKDTL.namevalue(i,"SEQ2")   = eval("txt_1"+i).value;
				dsT_EV_HWORKDTL.namevalue(i,"WORKGB") = eval("txt_2"+i).value;
				dsT_EV_HWORKDTL.namevalue(i,"WKCONT") = eval("txt_3"+i).value;
				dsT_EV_HWORKDTL.namevalue(i,"IMPORT") = eval("txt_4"+i).value;
				dsT_EV_HWORKDTL.namevalue(i,"REMARK") = eval("txt_5"+i).value;

			}

			/******************************************************************************
				Description : ����Ÿ �� ��� ����
			******************************************************************************/
			function fnc_SetDataHeader(gbn){

				if(gbn==1){       //�����Ű�MST

					if (dsT_EV_HWORKMST.countrow<1){
						var s_temp = " EVAYM:STRING(7),EMPNO:STRING(7),EMPNMK:STRING(30),HEADCD:STRING(4),HEADNM:STRING(50),"
						           + " DIVCD:STRING(4),DIVNM:STRING(50),DEPTCD:STRING(4),DEPTNMK:STRING(50),PAYGRD:STRING(4),PAYGRDNM:STRING(50), "
											 + " WORK_1:STRING(50),STARTDT_1:STRING(8),ENDDT_1:STRING(8),PLACE_1:STRING(50),REMARK_1:STRING(100),"
											 + " WORK_2:STRING(50),STARTDT_2:STRING(8),ENDDT_2:STRING(8),PLACE_2:STRING(50),REMARK_2:STRING(100),"
											 + " WORK_3:STRING(50),STARTDT_3:STRING(8),ENDDT_3:STRING(8),PLACE_3:STRING(50),REMARK_3:STRING(100),"
											 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
						dsT_EV_HWORKMST.SetDataHeader(s_temp);
					}

				}else if(gbn==2){ //�����Ű�DTL

					if (dsT_EV_HWORKDTL.countrow<1){
						var s_temp = " EVAYM:STRING(7),EMPNO:STRING(7),SEQ2:DECIMAL(2),WORKGB:STRING(50),WKCONT:STRING(2048),"
											 + " IMPORT:DECIMAL(3),REMARK:STRING(100),"
											 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
						dsT_EV_HWORKDTL.SetDataHeader(s_temp);
					}

				}else if(gbn==3){ //print head

					if (dsT_EV_HWORKPRT.countrow<1){
						var s_temp = " TITLE:STRING(50),TERM:STRING(50),EMPNMK:STRING(30),"
						           + " DATE1:STRING(50),DEPT1:STRING(50),CONTENT1:STRING(2048),REMARK1:STRING(100),"
											 + " DATE2:STRING(50),DEPT2:STRING(50),CONTENT2:STRING(2048),REMARK2:STRING(100),"
											 + " DATE3:STRING(50),DEPT3:STRING(50),CONTENT3:STRING(2048),REMARK3:STRING(100)";
						dsT_EV_HWORKPRT.SetDataHeader(s_temp);
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

   			if(!fnc_Save_Chk()) return;

   			fnc_SetDataHeader(1);

			 dsT_EV_HWORKMST.addrow();

			 var row = dsT_EV_HWORKMST.rowposition;

			 var row2 = parent.dsT_EV_HWORKMST.rowposition;

			 dsT_EV_HWORKMST.namevalue(row,"EVAYM")		=parent.dsT_EV_HWORKMST.namevalue(row2,"EVAYM");
			 dsT_EV_HWORKMST.namevalue(row,"EMPNO")		=parent.dsT_EV_HWORKMST.namevalue(row2,"EMPNO");
			 dsT_EV_HWORKMST.namevalue(row,"EMPNMK")	=parent.dsT_EV_HWORKMST.namevalue(row2,"EMPNMK");
			 dsT_EV_HWORKMST.namevalue(row,"HEADCD")	=parent.dsT_EV_HWORKMST.namevalue(row2,"HEADCD");
			 dsT_EV_HWORKMST.namevalue(row,"DIVCD")		=parent.dsT_EV_HWORKMST.namevalue(row2,"DIVCD");
			 dsT_EV_HWORKMST.namevalue(row,"DEPTCD")	=parent.dsT_EV_HWORKMST.namevalue(row2,"DEPTCD");
			 dsT_EV_HWORKMST.namevalue(row,"PAYGRD")	=parent.dsT_EV_HWORKMST.namevalue(row2,"PAYGRD");
			 dsT_EV_HWORKMST.namevalue(row,"WORK_1")	=parent.dsT_EV_HWORKMST.namevalue(row2,"WORK_1");
			 dsT_EV_HWORKMST.namevalue(row,"STARTDT_1")	=parent.dsT_EV_HWORKMST.namevalue(row2,"STARTDT_1");
			 dsT_EV_HWORKMST.namevalue(row,"ENDDT_1")	=parent.dsT_EV_HWORKMST.namevalue(row2,"ENDDT_1");
			 dsT_EV_HWORKMST.namevalue(row,"PLACE_1")	=parent.dsT_EV_HWORKMST.namevalue(row2,"PLACE_1");
			 dsT_EV_HWORKMST.namevalue(row,"REMARK_1")	=parent.dsT_EV_HWORKMST.namevalue(row2,"REMARK_1");
			 dsT_EV_HWORKMST.namevalue(row,"WORK_2")	=parent.dsT_EV_HWORKMST.namevalue(row2,"WORK_2");
			 dsT_EV_HWORKMST.namevalue(row,"STARTDT_2")	=parent.dsT_EV_HWORKMST.namevalue(row2,"STARTDT_2");
			 dsT_EV_HWORKMST.namevalue(row,"ENDDT_2")	=parent.dsT_EV_HWORKMST.namevalue(row2,"ENDDT_2");
			 dsT_EV_HWORKMST.namevalue(row,"PLACE_2")	=parent.dsT_EV_HWORKMST.namevalue(row2,"PLACE_2");
			 dsT_EV_HWORKMST.namevalue(row,"REMARK_2")	=parent.dsT_EV_HWORKMST.namevalue(row2,"REMARK_2");
			 dsT_EV_HWORKMST.namevalue(row,"WORK_3")	=parent.dsT_EV_HWORKMST.namevalue(row2,"WORK_3");
			 dsT_EV_HWORKMST.namevalue(row,"STARTDT_3")	=parent.dsT_EV_HWORKMST.namevalue(row2,"STARTDT_3");
			 dsT_EV_HWORKMST.namevalue(row,"ENDDT_3")	=parent.dsT_EV_HWORKMST.namevalue(row2,"ENDDT_3");
			 dsT_EV_HWORKMST.namevalue(row,"PLACE_3")	=parent.dsT_EV_HWORKMST.namevalue(row2,"PLACE_3");
			 dsT_EV_HWORKMST.namevalue(row,"REMARK_3")	=parent.dsT_EV_HWORKMST.namevalue(row2,"REMARK_3");

			for(i=1;i<=gs_seq;i++){

			  if(dsT_EV_HWORKDTL.SysStatus(i)!=2){

				  fnc_Data(i);

				}
			}

            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_HWORKMST=dsT_EV_HWORKMST,I:dsT_EV_HWORKDTL=dsT_EV_HWORKDTL)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui120.cmd.VLUI120CMD&S_MODE=SAV";

			//prompt('dsT_EV_HWORKMST',dsT_EV_HWORKMST.text);
			//prompt('dsT_EV_HWORKDTL',dsT_EV_HWORKDTL.text);

            trT_EV_ABLRST.post();

        }



		/******************************************************************************
			Description : �Է°� üũ
		******************************************************************************/
		function fnc_Save_Chk() {

		  var dbltemp=0;

		  //�ʼ��׸� üũ
		 	for(i=1;i<=gs_seq;i++){

				if(eval("txt_2"+i).value==""){
					alert("�׸��� �Է��Ͻʽÿ�.");
					//return false;
				}

				if(eval("txt_2"+i).value.length>=45) {
					alert( i+" ��° �׸� ���̰� ��ϴ�." );
					//return false
				}

				if(eval("txt_3"+i).value==""){
					alert("�ֿ���������� �Է��Ͻʽÿ�.");
					//return false;
				}

				if(eval("txt_4"+i).value==""){
					alert("����ġ�� �Է��Ͻʽÿ�.");
					//return false;
				}

				 eval("txt_4"+i).value=fnc_trim(eval("txt_4"+i).value);
			}

		  //����üũ
			var str="";

			for(j=1;j<=gs_seq;j++){
				str="txt_4"+j+"";
			  if(!fnc_ChkNumber(str)) return false;
		  	}

		  	for(j=1;j<=gs_seq;j++){
				dbltemp=parseInt(dbltemp)+parseInt(eval("txt_4"+j).value);
		  	}

			if(dbltemp!=100) {
				alert("����ġ �հ谡 100�� �ƴմϴ�. Ȯ�� �ٶ��ϴ�.");
				//return false;
			}

			return true;
		}



		/******************************************************************************************
			Descrition : ��¥�� ���� üũ
		******************************************************************************************/
		function fnc_ChkNumber(obj){
			var str="";
			var sChk=0;
			var src=eval(obj).value;

			for(var i=0;i<src.length;i++){
				if(isNaN(src.charAt(i))||src.charAt(i)==" ") sChk+=1;
				else str+=src.charAt(i);
			}

			if(sChk!=0){
				alert("����ġ���� ���ڸ� �Է��Ͻʽÿ�.");
				obj.value=src;
				//return false;
			}
			return true;
		}

		/******************************************************************************************
				// �������� Trim
		******************************************************************************************/
		function fnc_trim(str){

			var index,len;

			while(true){
				index = str.indexOf(" ");
				if(index == -1) break
				len = str.length;
				str = str.substring(0, index) + str.substring((index + 1),len)
			}
			return str;
		}

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			   if (table_1.rows.length>1) {

					dsT_EV_HWORKDTL.DeleteRow(gs_seq);

				    gs_seq-=1;

			      	table_1.deleteRow();

			   }
        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

			    var s_startdt_1	=parent.dsT_EV_HWORKMST.namevalue(1,"STARTDT_1");
				var s_enddt_1	=parent.dsT_EV_HWORKMST.namevalue(1,"ENDDT_1");
				var s_startdt_2	=parent.dsT_EV_HWORKMST.namevalue(1,"STARTDT_2");
				var s_enddt_2	=parent.dsT_EV_HWORKMST.namevalue(1,"ENDDT_2");
				var s_startdt_3	=parent.dsT_EV_HWORKMST.namevalue(1,"STARTDT_3");
				var s_enddt_3	=parent.dsT_EV_HWORKMST.namevalue(1,"ENDDT_3");

			  	dsT_EV_HWORKPRT.ClearAll();

				fnc_SetDataHeader(3);

			  	dsT_EV_HWORKPRT.Addrow();

				dsT_EV_HWORKPRT.namevalue(1,"TITLE")=gs_gb+" �����Ű�";
				dsT_EV_HWORKPRT.namevalue(1,"TERM")="(���Ⱓ : "+ parent.document.form1.txt_term.value + ")";
				dsT_EV_HWORKPRT.namevalue(1,"EMPNMK")	=parent.dsT_EV_HWORKMST.namevalue(1,"EMPNMK");

				if(s_startdt_1!=""&&s_enddt_1!=""){
					dsT_EV_HWORKPRT.namevalue(1,"DATE1")=s_startdt_1.substring(4,6)+"."+s_startdt_1.substring(6,8)+" ~ "+s_enddt_1.substring(4,6)+"."+s_enddt_1.substring(6,8);
				}
				dsT_EV_HWORKPRT.namevalue(1,"DEPT1")	=parent.dsT_EV_HWORKMST.namevalue(1,"PLACE_1");
				dsT_EV_HWORKPRT.namevalue(1,"CONTENT1")	=parent.dsT_EV_HWORKMST.namevalue(1,"WORK_1");
				dsT_EV_HWORKPRT.namevalue(1,"REMARK1")	=parent.dsT_EV_HWORKMST.namevalue(1,"REMARK_1");

				if(s_startdt_2!=""&&s_enddt_2!=""){
					dsT_EV_HWORKPRT.namevalue(1,"DATE2")=s_startdt_2.substring(4,6)+"."+s_startdt_2.substring(6,8)+" ~ "+s_enddt_2.substring(4,6)+"."+s_enddt_2.substring(6,8);
				}
				dsT_EV_HWORKPRT.namevalue(1,"DEPT2")	=parent.dsT_EV_HWORKMST.namevalue(1,"PLACE_2");
				dsT_EV_HWORKPRT.namevalue(1,"CONTENT2")	=parent.dsT_EV_HWORKMST.namevalue(1,"WORK_2");
				dsT_EV_HWORKPRT.namevalue(1,"REMARK2")	=parent.dsT_EV_HWORKMST.namevalue(1,"REMARK_2");

				if(s_startdt_3!=""&&s_enddt_3!=""){
					dsT_EV_HWORKPRT.namevalue(1,"DATE3")=s_startdt_3.substring(4,6)+"."+s_startdt_3.substring(6,8)+" ~ "+s_enddt_3.substring(4,6)+"."+s_enddt_3.substring(6,8);
				}
				dsT_EV_HWORKPRT.namevalue(1,"DEPT3")	=parent.dsT_EV_HWORKMST.namevalue(1,"PLACE_3");
				dsT_EV_HWORKPRT.namevalue(1,"CONTENT3")	=parent.dsT_EV_HWORKMST.namevalue(1,"WORK_3");
				dsT_EV_HWORKPRT.namevalue(1,"REMARK3")	=parent.dsT_EV_HWORKMST.namevalue(1,"REMARK_3");

			    //������
	            var evaym = parent.document.form1.txtREG_YM_SHR.value;        	//�ش�⵵
				var ENO_NO = parent.document.form1.txtENO_NO_SHR.value;			//���

	        	dsT_EV_LENGTH.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui120.cmd.VLUI120CMD&S_MODE=SHR_LENGTH&evaym="+evaym+"&ENO_NO="+ENO_NO;
	        	dsT_EV_LENGTH.reset();

				var len = dsT_EV_LENGTH.namevalue(1,"LEN");
				var gbn ="";


				
				if(len<=200){ //8ĭ
			    	gbn="1";
				}else if(len>200 && len<=270){ //7ĭ
					gbn="2";
				}else if(len>270 && len<=350){ //5ĭ
					gbn="3";
				}else if(len>350 && len<=570){ //4ĭ
				  	gbn="4";
				}else if (len>570 && len<=865){//3ĭ
			    	gbn="5";
				}else if (len>865 ){//2ĭ
			    	gbn="6";
				}else{
					alert("����� ����Ÿ�� �����ϴ�.");
				}

				fnc_Print_Format(gbn);

				gcrp_print1.preview();

        }


        function fnc_Print_Format(gbn) {


		  var ls_format= "";

			if(gbn=="1"){	//200
				ls_format +="	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                  ";
				ls_format +="	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
				ls_format +="	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                  ";
				ls_format +="	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		    	ls_format +="	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
				ls_format +="	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                    ";
				ls_format +="	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
				ls_format +="	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
				ls_format +="	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		    	ls_format +="	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +="	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		    	ls_format +="	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
		    	ls_format +="	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
				ls_format +="	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
				ls_format +="	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
				ls_format +="	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                 ";
				ls_format +="	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                  ";
				ls_format +="	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
		    	ls_format +="</B>                                                                                                                                                                                                                                      ";
				ls_format +="<B>id=default ,left=0,top=0 ,right=2000 ,bottom=225 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
				ls_format +="	<L> left=71 ,top=0 ,right=71 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="	<L> left=159 ,top=0 ,right=159 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=439 ,top=0 ,right=439 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=1942 ,top=0 ,right=1942 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1709 ,top=5 ,right=1709 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1529 ,top=5 ,right=1529 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<C>id='SEQ2', left=79, top=5, right=151, bottom=220, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
				ls_format +="	<C>id='WKCONT', left=445, top=5, right=1521, bottom=220, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
				ls_format +="	<C>id='REMARK', left=1715, top=5, right=1937, bottom=220, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
				ls_format +="	<L> left=71 ,top=225 ,right=1942 ,bottom=225 </L>                                                                                                                                                                                       ";
		    	ls_format +="	<C>id='IMPORT', left=1577, top=77, right=1667, bottom=153, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
				ls_format +="	<C>id='WORKGB', left=169, top=5, right=431, bottom=220, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
				ls_format +="</B>                                                                                                                                                                                                                                      ";
				ls_format +="<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                      ";
				ls_format +="	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="</B>                                                                                                                                                                                                                                      ";
				ls_format +="<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                ";
				ls_format +="	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
				ls_format +="	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                    ";
				ls_format +="</B>                                                                                                                                                                                                                                      ";

			}else if(gbn=="2"){ //295
			  	ls_format +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
		 	  	ls_format +=" 	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              ";
				ls_format +=" 	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              ";
				ls_format +=" 	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +=" 	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              ";
				ls_format +=" 	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                   ";
				ls_format +=" 	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		 	  	ls_format +=" 	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
				ls_format +=" 	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                          ";
				ls_format +=" 	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		 	  	ls_format +=" 	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     ";
				ls_format +=" 	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              ";
		 	  	ls_format +=" 	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                   ";
				ls_format +=" 	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +=" 	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +=" 	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
				ls_format +=" 	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
		    	ls_format +=" 	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
				ls_format +=" 	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
				ls_format +=" 	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +=" 	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +=" 	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +=" 	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +=" 	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +=" 	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +=" 	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
				ls_format +=" 	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
				ls_format +=" 	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
				ls_format +=" 	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                            ";
				ls_format +=" 	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
		    	ls_format +=" 	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		 	  	ls_format +=" 	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              ";
				ls_format +=" 	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
				ls_format +=" 	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
				ls_format +=" 	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                  ";
		 	  	ls_format +=" 	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                   ";
				ls_format +=" 	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                       ";
				ls_format +=" </B>                                                                                                                                                                                                                                       ";
				ls_format +=" <B>id=default ,left=0,top=0 ,right=2000 ,bottom=518 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";

				ls_format +=" 	<C>id='WORKGB', left=169, top=5, right=431, bottom=507, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                          ";
		 	  	ls_format +=" 	<C>id='IMPORT', left=1577, top=122, right=1667, bottom=398, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
				ls_format +=" 	<C>id='SEQ2', left=79, top=53, right=151, bottom=467, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
				ls_format +=" 	<C>id='WKCONT', left=445, top=5, right=1521, bottom=507, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
				ls_format +=" 	<C>id='REMARK', left=1715, top=5, right=1937, bottom=507, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";

				ls_format +=" 	<L> left=71 ,top=0 ,right=71 ,bottom=512 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +=" 	<L> left=159 ,top=0 ,right=159 ,bottom=512 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<L> left=439 ,top=0 ,right=439 ,bottom=512 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<L> left=1529 ,top=0 ,right=1529 ,bottom=512 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=1709 ,top=0 ,right=1709 ,bottom=512 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
		 	  	ls_format +=" 	<L> left=1942 ,top=0 ,right=1942 ,bottom=512 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=69 ,top=512 ,right=1939 ,bottom=512 </L>                                                                                                                                                                                        ";
				ls_format +=" </B>                                                                                                                                                                                                                                       ";
		    	ls_format +=" <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=3 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                       ";
				ls_format +=" 	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +=" </B>                                                                                                                                                                                                                                       ";
				ls_format +=" <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                 ";
				ls_format +=" 	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +=" 	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>      ";
				ls_format +=" 	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                     ";
				ls_format +=" </B>                                                                                                                                                                                                                                       ";
		  }else if(gbn=="3"){ //350
			  	ls_format +="  <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
				ls_format +="  	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="  	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="  	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
				ls_format +="  	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="  	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                  ";
				ls_format +="  	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="  	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
				ls_format +="  	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="  	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="  	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                    ";
				ls_format +="  	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
				ls_format +="  	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
				ls_format +="  	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +="  	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +="  	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="  	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="  	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="  	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="  	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="  	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="  	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="  	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="  	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="  	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="  	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="  	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="  	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="  	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="  	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
				ls_format +="  	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
				ls_format +="  	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="  	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
				ls_format +="  	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
				ls_format +="  	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="  	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                 ";
				ls_format +="  	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                  ";
				ls_format +="  	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
				ls_format +="  </B>                                                                                                                                                                                                                                      ";
				ls_format +="  <B>id=default ,left=0,top=0 ,right=2000 ,bottom=381 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";
				ls_format +="  	<L> left=71 ,top=0 ,right=71 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="  	<C>id='WORKGB', left=169, top=5, right=431, bottom=370, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
				ls_format +="  	<C>id='SEQ2', left=79, top=79, right=151, bottom=294, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                         ";
				ls_format +="  	<C>id='IMPORT', left=1577, top=146, right=1667, bottom=222, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                   ";
				ls_format +="  	<L> left=159 ,top=0 ,right=159 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="  	<L> left=439 ,top=0 ,right=439 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="  	<L> left=1529 ,top=0 ,right=1529 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=1709 ,top=0 ,right=1709 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<L> left=1942 ,top=0 ,right=1942 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="  	<C>id='WKCONT', left=445, top=5, right=1521, bottom=370, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
				ls_format +="  	<C>id='REMARK', left=1715, top=5, right=1937, bottom=370, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
				ls_format +="  	<L> left=71 ,top=378 ,right=1942 ,bottom=378 </L>                                                                                                                                                                                       ";
				ls_format +="  </B>                                                                                                                                                                                                                                      ";
				ls_format +="  <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=2 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                      ";
				ls_format +="  	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="  </B>                                                                                                                                                                                                                                      ";
				ls_format +="  <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                ";
				ls_format +="  	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="  	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
				ls_format +="  	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                    ";
				ls_format +="  </B>                                                                                                                                                                                                                                      ";


			}else if(gbn=="4"){ //570
			  	ls_format +="	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                  ";
				ls_format +="	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
				ls_format +="	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             ";
				ls_format +="	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                  ";
				ls_format +="	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
		    	ls_format +="	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
				ls_format +="	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                    ";
				ls_format +="	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
				ls_format +="	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
				ls_format +="	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		    	ls_format +="	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +="	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      ";
				ls_format +="	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +="	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		    	ls_format +="	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +="	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
				ls_format +="	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
		    	ls_format +="	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
				ls_format +="	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +="	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                             ";
				ls_format +="	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
				ls_format +="	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                 ";
				ls_format +="	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                  ";
				ls_format +="	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
		    	ls_format +="</B>                                                                                                                                                                                                                                      ";
				ls_format +="<B>id=default ,left=0,top=0 ,right=2000 ,bottom=645 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                    ";


				ls_format +="	<C>id='WORKGB', left=169, top=5, right=431, bottom=637, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         ";
				ls_format +="	<C>id='IMPORT', left=1577, top=183, right=1667, bottom=459, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                   ";
				ls_format +="	<C>id='SEQ2', left=79, top=116, right=151, bottom=531, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                        ";
				ls_format +="	<C>id='WKCONT', left=445, top=5, right=1521, bottom=637, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
		    	ls_format +="	<C>id='REMARK', left=1715, top=5, right=1937, bottom=637, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";

				ls_format +="	<L> left=71 ,top=0 ,right=71 ,bottom=645 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="	<L> left=159 ,top=0 ,right=159 ,bottom=645 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=439 ,top=0 ,right=439 ,bottom=645 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                           ";
				ls_format +="	<L> left=1529 ,top=0 ,right=1529 ,bottom=645 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1709 ,top=0 ,right=1709 ,bottom=645 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=1942 ,top=0 ,right=1942 ,bottom=645 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=645 ,right=1942 ,bottom=645 </L>                                                                                                                                                                                       ";
				ls_format +="</B>                                                                                                                                                                                                                                      ";
				ls_format +="<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                      ";
				ls_format +="	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="</B>                                                                                                                                                                                                                                      ";
				ls_format +="<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                ";
				ls_format +="	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
				ls_format +="	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                    ";
				ls_format +="</B>                                                                                                                                                                                                                                      ";

			}else if(gbn=="5"){ //865
				ls_format +="	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                       ";
				ls_format +="	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                  ";
				ls_format +="	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                  ";
				ls_format +="	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                 ";
				ls_format +="	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                                  ";
				ls_format +="	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                       ";
				ls_format +="	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
		    	ls_format +="	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
				ls_format +="	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                              ";
				ls_format +="	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
				ls_format +="	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
				ls_format +="	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         ";
				ls_format +="	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
				ls_format +="	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
				ls_format +="	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
		    	ls_format +="	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                             ";
				ls_format +="	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
				ls_format +="	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
				ls_format +="	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
				ls_format +="	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                           ";
				ls_format +="	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
				ls_format +="	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
				ls_format +="	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          ";
				ls_format +="	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
		    	ls_format +="	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                        ";
				ls_format +="	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                        ";
				ls_format +="	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                        ";
				ls_format +="	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                         ";
				ls_format +="	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                         ";
				ls_format +="	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                         ";
				ls_format +="	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
				ls_format +="	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                                ";
		    	ls_format +="	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                      ";
				ls_format +="	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +="	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  ";
				ls_format +="	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                             ";
				ls_format +="	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                           ";
				ls_format +="	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                      ";
				ls_format +="	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       ";
				ls_format +="	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                           ";
		    	ls_format +="</B>                                                                                                                                                                                                                                           ";
				ls_format +="<B>id=default ,left=0,top=0 ,right=2000 ,bottom=625 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                         ";
				ls_format +="	<L> left=71 ,top=0 ,right=71 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                  ";
				ls_format +="	<C>id='WORKGB', left=169, top=5, right=431, bottom=614, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                              ";
				ls_format +="	<L> left=159 ,top=0 ,right=159 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
				ls_format +="	<L> left=439 ,top=0 ,right=439 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                ";
				ls_format +="	<L> left=1529 ,top=0 ,right=1529 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=1709 ,top=0 ,right=1709 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<L> left=1942 ,top=0 ,right=1942 ,bottom=619 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              ";
				ls_format +="	<C>id='WKCONT', left=445, top=5, right=1521, bottom=614, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                             ";
				ls_format +="	<C>id='REMARK', left=1715, top=5, right=1937, bottom=614, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                            ";
				ls_format +="	<L> left=71 ,top=624 ,right=1942 ,bottom=624 </L>                                                                                                                                                                                            ";
		    	ls_format +="	<C>id='IMPORT', left=1577, top=275, right=1667, bottom=352, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                        ";
				ls_format +="	<C>id='SEQ2', left=79, top=201, right=151, bottom=415, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                             ";
				ls_format +="</B>                                                                                                                                                                                                                                           ";
				ls_format +="<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                           ";
				ls_format +="	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                  ";
				ls_format +="</B>                                                                                                                                                                                                                                           ";
				ls_format +="<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
				ls_format +="	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                                  ";
				ls_format +="	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>          ";
				ls_format +="	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                         ";
				ls_format +="</B>                                                                                                                                                                                                                                           ";

			}else if(gbn=="6"){ //865�̻�
		    	ls_format +=" 	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                  ";
				ls_format +=" 	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
				ls_format +=" 	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
				ls_format +=" 	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                           ";
				ls_format +=" 	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                            ";
				ls_format +=" 	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                 ";
				ls_format +=" 	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
		    	ls_format +=" 	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     ";
				ls_format +=" 	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                        ";
				ls_format +=" 	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                   ";
				ls_format +=" 	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                            ";
				ls_format +=" 	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                 ";
				ls_format +=" 	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
		    	ls_format +=" 	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                       ";
				ls_format +=" 	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +=" 	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +=" 	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +=" 	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                     ";
				ls_format +=" 	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
				ls_format +=" 	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
				ls_format +=" 	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    ";
				ls_format +=" 	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
		    	ls_format +=" 	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
				ls_format +=" 	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
				ls_format +=" 	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
				ls_format +=" 	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +=" 	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +=" 	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
				ls_format +=" 	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                          ";
		    	ls_format +=" 	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                ";
				ls_format +=" 	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                      ";
				ls_format +=" 	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                            ";
				ls_format +=" 	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       ";
				ls_format +=" 	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     ";
				ls_format +=" 	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                ";
				ls_format +=" 	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                 ";
				ls_format +=" 	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
		    	ls_format +=" </B>                                                                                                                                                                                                                                     ";
				ls_format +=" <B>id=default ,left=0,top=0 ,right=2000 ,bottom=955 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                   ";
				ls_format +=" 	<L> left=71 ,top=0 ,right=71 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<C>id='WORKGB', left=169, top=5, right=431, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        ";
				ls_format +=" 	<C>id='IMPORT', left=1577, top=458, right=1667, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                  ";
				ls_format +=" 	<C>id='SEQ2', left=77, top=389, right=148, bottom=603, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       ";
				ls_format +=" 	<L> left=159 ,top=0 ,right=159 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=439 ,top=0 ,right=439 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          ";
				ls_format +=" 	<L> left=1529 ,top=0 ,right=1529 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=1709 ,top=0 ,right=1709 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<L> left=1942 ,top=0 ,right=1942 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        ";
				ls_format +=" 	<C>id='WKCONT', left=445, top=5, right=1521, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                       ";
		    	ls_format +=" 	<C>id='REMARK', left=1715, top=5, right=1937, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                      ";
				ls_format +=" 	<L> left=71 ,top=955 ,right=1942 ,bottom=955 </L>                                                                                                                                                                                      ";
				ls_format +=" </B>                                                                                                                                                                                                                                     ";
				ls_format +=" <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     ";
				ls_format +=" 	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" </B>                                                                                                                                                                                                                                     ";
				ls_format +=" <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                               ";
				ls_format +=" 	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            ";
				ls_format +=" 	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>    ";
				ls_format +=" 	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                   ";
				ls_format +=" </B>                                                                                                                                                                                                                                     ";

			} else if(gbn=="9") {

		    	ls_format +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                         "
				ls_format +=" 	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              "
				ls_format +=" 	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              "
				ls_format +=" 	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                             "
				ls_format +=" 	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                              "
				ls_format +=" 	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>                                                                   "
				ls_format +=" 	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       "
				ls_format +=" 	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                          "
				ls_format +=" 	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
				ls_format +=" 	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
				ls_format +=" 	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                     "
				ls_format +=" 	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              "
				ls_format +=" 	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                   "
				ls_format +=" 	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         "
				ls_format +=" 	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                         "
				ls_format +=" 	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
				ls_format +=" 	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
				ls_format +=" 	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
				ls_format +=" 	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                       "
				ls_format +=" 	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      "
				ls_format +=" 	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      "
				ls_format +=" 	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                      "
				ls_format +=" 	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    "
				ls_format +=" 	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    "
				ls_format +=" 	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    "
				ls_format +=" 	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     "
				ls_format +=" 	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     "
				ls_format +=" 	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     "
				ls_format +=" 	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
				ls_format +=" 	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                            "
				ls_format +=" 	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                  "
				ls_format +=" 	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                        "
				ls_format +=" 	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                              "
				ls_format +=" 	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                         "
				ls_format +=" 	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                                                                       "
				ls_format +=" 	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                  "
				ls_format +=" 	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                   "
				ls_format +=" 	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                       "
				ls_format +=" </B>                                                                                                                                                                                                                                           "
				ls_format +=" <B>id=default ,left=0,top=0 ,right=2000 ,bottom=310 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                         "
				ls_format +=" 	<L> left=71 ,top=0 ,right=71 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              "
				ls_format +=" 	<C>id='WORKGB', left=169, top=5, right=431, bottom=302, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                          "
				ls_format +=" 	<L> left=159 ,top=0 ,right=159 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
				ls_format +=" 	<L> left=439 ,top=0 ,right=439 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                            "
				ls_format +=" 	<L> left=1529 ,top=0 ,right=1529 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=1709 ,top=0 ,right=1709 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<L> left=1942 ,top=0 ,right=1942 ,bottom=299 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                          "
				ls_format +=" 	<C>id='SEQ2', left=79, top=48, right=151, bottom=262, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                          "
				ls_format +=" 	<C>id='IMPORT', left=1577, top=119, right=1667, bottom=196, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                    "
				ls_format +=" 	<C>id='WKCONT', left=445, top=5, right=1521, bottom=302, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                         "
				ls_format +=" 	<C>id='REMARK', left=1715, top=5, right=1937, bottom=302, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                                        "
				ls_format +=" 	<L> left=71 ,top=304 ,right=1942 ,bottom=304 </L>                                                                                                                                                                                        "
				ls_format +=" </B>                                                                                                                                                                                                                                           "
				ls_format +=" <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=3 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                           "
				ls_format +=" 	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              "
				ls_format +=" </B>                                                                                                                                                                                                                                           "
				ls_format +=" <B>id=Footer ,left=0 ,top=2728 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                                     "
				ls_format +=" 	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                              "
				ls_format +=" 	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>      "
				ls_format +=" 	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                     "
				ls_format +=" </B>                                                                                                                                                                                                                                           "

			}

			gcrp_print1.format=ls_format;

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




        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

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
    <Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKDTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKPRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_LENGTH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_HWORKDTL Event="OnLoadCompleted(row,colid)">

	  	var oRow;

		var oCell;

		for(i=1;i<=row;i++){

			if(i>1){

				gs_format="";

				oRow= table_1.insertRow();

				oCell = oRow.insertCell();

				fnc_SetFormat(i);

				oCell.innerHTML = gs_format;

			}

			//��ȸ ����Ÿ ������
			fnc_Display(i);
		}

		if (row==0)gs_seq = 1;

		else gs_seq = row;


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_HWORKDTL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        //fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table id="table_1" value="" width="798" border="0" cellspacing="0" cellpadding="0">
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->


<comment id="__NSID__">
<object  id=gcrp_print1 classid=CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089>
	<param name="MasterDataID"			value="dsT_EV_HWORKPRT">
	<param name="DetailDataID"			value="dsT_EV_HWORKDTL">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"				value="false">
  	<param name="PrintSetupDlgFlag" 	value="true">
	<param name="Format"				value="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=762 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=69 ,top=693 ,right=1939 ,bottom=759 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=74 ,top=331 ,right=1945 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=635 ,top=331 ,right=635 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=331 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=235 ,top=331 ,right=235 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1709 ,top=331 ,right=1709 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���' ,left=1715 ,top=333 ,right=1937 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='����' ,left=79 ,top=333 ,right=228 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1058 ,top=331 ,right=1058 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=405 ,right=1942 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=331 ,right=71 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=405 ,right=1942 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=405 ,right=71 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���Ⱓ' ,left=241 ,top=333 ,right=630 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='�ҼӺμ�(����)' ,left=640 ,top=333 ,right=1053 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='������' ,left=1064 ,top=333 ,right=1701 ,bottom=397 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=238 ,top=545 ,right=1939 ,bottom=545 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=474 ,right=1939 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATE1', left=241, top=418, right=630, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=79, top=487, right=228, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=74 ,top=614 ,right=1942 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=635 ,top=407 ,right=635 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATE2', left=241, top=487, right=630, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE3', left=241, top=558, right=630, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=407 ,right=1058 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEPT1', left=643, top=418, right=1050, bottom=466, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPT3', left=643, top=558, right=1050, bottom=606, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPT2', left=643, top=487, right=1050, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1709 ,top=407 ,right=1709 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CONTENT1', left=1064, top=418, right=1701, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CONTENT2', left=1064, top=487, right=1701, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CONTENT3', left=1064, top=558, right=1701, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK1', left=1715, top=418, right=1937, bottom=466, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK2', left=1715, top=487, right=1937, bottom=534, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK3', left=1715, top=558, right=1937, bottom=606, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=691 ,right=1942 ,bottom=691 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=762 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=691 ,right=71 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=159 ,top=691 ,right=159 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=235 ,top=407 ,right=235 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=77 ,top=696 ,right=153 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=439 ,top=691 ,right=439 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=691 ,right=1942 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����ġ(%)' ,left=1535 ,top=696 ,right=1707 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1709 ,top=691 ,right=1709 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1529 ,top=691 ,right=1529 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ֿ� ���� ����' ,left=445 ,top=696 ,right=1527 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='�׸�' ,left=164 ,top=696 ,right=434 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='���' ,left=1715 ,top=696 ,right=1937 ,bottom=759 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='1.�򰡴�� �Ⱓ�� �λ��̵�����(�ش��ڸ� ����)' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2.�����Ű�' ,left=71 ,top=627 ,right=908 ,bottom=691 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TERM', left=1003, top=262, right=1924, bottom=310, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

<B>id=default ,left=0,top=0 ,right=2000 ,bottom=955 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=71 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='WORKGB', left=169, top=5, right=431, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='IMPORT', left=1577, top=458, right=1667, bottom=534, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEQ2', left=77, top=389, right=148, bottom=603, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=159 ,top=0 ,right=159 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=439 ,top=0 ,right=439 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1529 ,top=0 ,right=1529 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1709 ,top=0 ,right=1709 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=950 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='WKCONT', left=445, top=5, right=1521, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='REMARK', left=1715, top=5, right=1937, bottom=945, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=71 ,top=955 ,right=1942 ,bottom=955 </L>
</B>

<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�� �� �����Ű��� ���κ� �����򰡽� �����ڷ�� Ȱ��˴ϴ�.' ,left=66 ,top=5 ,right=1146 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='#p / #t' ,left=873 ,top=56 ,right=1140 ,bottom=103 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
">

</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>



</body>
</html>


