<!--
*****************************************************
* @source       : misb170.jsp
* @description  : ����������ȸ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/13      �̽¿�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����������ȸ(misb170)</title>
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
    var nscp = (navigator.appName == "Netscape")

	//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
    var btnList = 'TFTTTTFT';

    /***********************************
     * 01. ��ȸ �Լ�_List ������ ��ȸ  *
     ***********************************/
    function fnc_SearchList() {
        var f = document.form1;

        var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
        var str_ymd = f.txtSTR_YMD_SHR.value;
        var end_ymd = f.txtEND_YMD_SHR.value;
        var acc_cd  = f.hidGBN_OCC_CD.value;
        var gbn_case = f.hidGBN_GBN_CASE.value;
        var param;
        var check_place = '';

			//���۳���� ������ ��ȸ����.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
				alert("�������� ���۳������ �����ϴ�.");
				document.getElementById("txtEND_YMD_SHR").focus();
				return false;
			}

			document.body.style.cursor='wait';

            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=hr.mis.b.misb170.cmd.MISB170CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&END_YMD_SHR="+end_ymd+"&GBN_CASE="+gbn_case+"&OCC_CD="+OCC_CD;
            dsT_CM_PERSON.Reset();

            document.body.style.cursor='auto';

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

		if( !fnc_SaveItemCheck() )	return;

        var f = document.form1;
        var gbn_case = f.hidGBN_GBN_CASE.value;

        if(gbn_case == "R"){
			//Ʈ����� ����
			trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
			trT_CM_PERSON.Action = "/servlet/GauceChannelSVL?cmd=hr.mis.b.misb170.cmd.MISB170CMD&S_MODE=SAV";
			trT_CM_PERSON.Post();
        }

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
        var f = document.form1;

        /*if ( f.flag.value == "Y" )
        {
             form1.aaa.RunButton('print_go');
        }
        else alert("������ȸ �� �μ� �Ͻñ� �ٶ��ϴ�.");*/

        var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
        var str_ymd = f.txtSTR_YMD_SHR.value;
        var end_ymd = f.txtEND_YMD_SHR.value;
        var acc_cd  = f.hidGBN_OCC_CD.value;
        var gbn_case = f.hidGBN_GBN_CASE.value;
        var param;


			//���۳���� ������ ��ȸ����.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
					alert("�������� ���۳������ �����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}



        var url = "misb170_PV.jsp?str_ymd="+str_ymd+"&end_ymd="+end_ymd+"&OCC_CD="+OCC_CD+"&acc_cd="+acc_cd+"&gbn_case="+gbn_case;
        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

    }

    /***********************
     * 06. ���� ���� �Լ�  *
     ***********************/
    function fnc_ToExcel() {

		var gbn_case = document.form1.hidGBN_GBN_CASE.value;

		if (dsT_CM_PERSON.CountRow < 1) {
		    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
		    return;
		}

		if(gbn_case == "H"){
			form1.grdT_CM_PERSON.GridToExcel("�Ի�����Ȳ", '', 225);
		}else if(gbn_case == "R"){
			form1.grdT_CM_PERSON.GridToExcel("�������Ȳ", '', 225);
		}else if(gbn_case == "J"){
			form1.grdT_CM_PERSON.GridToExcel("��������Ȳ", '', 225);
		}else if(gbn_case == "K"){
            form1.grdT_CM_PERSON.GridToExcel("��������Ȳ", '', 225);
        }else if(gbn_case == "L"){
            form1.grdT_CM_PERSON.GridToExcel("�ٷα��к�������Ȳ",'',225);
        }else if(gbn_case == "C"){
            form1.grdT_CM_PERSON.GridToExcel("��������������Ȳ",'',225);
        }

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

		fnc_OnLoadProcess();
		dsT_CM_PERSON.ClearData();
		document.getElementById("resultMessage").innerText = ' ';
		document.getElementById('cmbOCC_CD_SHR').value = "";
		document.form1.rdoGBN_GBN_CASE[0].checked = true;
		document.form1.txtSTR_YMD_SHR.focus();

    }

    /************************
     * 11. ȭ�� ����(�ݱ�)  *
     ***********************/
    function fnc_Exit() {

      frame = window.external.GetFrame(window);
      frame.CloseFrame();

   }

    /******************************
     * 12. �˻� ���� ��ȿ�� �˻�  *
     ******************************/
    function fnc_SearchItemCheck() {

  //�̰��� �ش� �ڵ��� �Է� �ϼ���

    }

    /*************************
     * 13. ���� ��ȿ�� üũ  *
     *************************/
    function fnc_SaveItemCheck() {

		if (!dsT_CM_PERSON.IsUpdated) {
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

		fnc_ChangeGrid();      //�׸��� ���� ó��

		document.getElementById('txtSTR_YMD_SHR').value = getToday().substring(0,7)+"-01";
		document.getElementById('txtEND_YMD_SHR').value = getToday();

		//��ġ�ڵ�
		if(document.getElementById("cmbRETM_CD").length == 0){
			for( var i = 1; i <= dsT_CM_COMMON_CB.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_CB.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_CB.NameValue(i,"CODE_NAME");
				document.getElementById("cmbRETM_CD").add(oOption);
			}
		}

     }

    /********************
    * 15. ����Ű ó��  *
    *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }

    /********************************************
    * ��¥ ���� ��ȿ�� üũ                     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

    /********************************************
    * ez-gen ��ư Ŭ�� �̺�Ʈ                   *
    ********************************************/
    function winclose()
    {
        window.close();
    }
    function goclick(x)
    {
        if( !document.form1.aaa.RunButton(x)) alert("��ü�� �����ϴ�.");
    }

        /*************************
         * �׸��� ���� ó��               *
         ************************/
		function fnc_ChangeGrid() {
			var gbn_case = document.form1.hidGBN_GBN_CASE.value;
			dsT_CM_PERSON.ClearData();

			disableInput();

			if(gbn_case == "H"){  // �Ի���
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='�Ҽ�'				align=center										</FC>" +
												"<FC> id='JOB_NM'			width=60		name='����'				align=center										</FC>" +
												"<FC> id='ENO_NO'			width=70		name='���'				align=center										</FC>" +
												"<FC> id='ENO_NM'			width=70		name='����' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='�ٷα���'			align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='�ֹι�ȣ'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='����'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='�б�'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='����'				align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='�Ի���'			align=center										</C>" +
											    "<C> id='RET_YMD'			width=80		name='�����'			align=center										</C>" +
												"<C> id='HIR_NM'			width=100		name='�Ի籸��'			align=center										</C>" +
												"<C> id='ABA_NM'			width=90		name='�����'			align=center										</C>" +
												"<C> id='ACC_NO'			width=120		name='���¹�ȣ'			align=center										</C>";

				//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
				//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
				cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

			}else if(gbn_case == "R"){  // �����
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='�Ҽ�'				align=center										</FC>" +
												"<FC> id='JOB_NM'			width=60		name='����'				align=center										</FC>" +
												"<FC> id='ENO_NO'			width=70		name='���'				align=center										</FC>" +
												"<FC> id='ENO_NM'			width=70		name='����' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='�ٷα���'			align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='�ֹι�ȣ'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='����'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='�б�'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='����'				align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='�Ի���'			align=center										</C>" +
												"<C> id='RET_YMD'			width=80		name='�����'			align=center										</C>" +
												"<C> id='RET_NM'			width=100		name='��籸��'			align=center										</C>" +
                                                "<C> id='ABA_NM'            width=90       name='�����'            align=center                                        </C>" +
                                                "<C> id='ACC_NO'            width=120       name='���¹�ȣ'         align=center                                        </C>" +
												"<C> id='RETM_CD'			width=80		name='��ġ����'			align=center		EditStyle=Lookup  Data='dsT_CM_COMMON_CB:CODE:CODE_NAME'	</C>" +
												"<C> id='RETM_REM'			width=120		name='��ġ�ڻ��'		align=center										</C>" +
												"<C> id='RETM_REM_NM'		width=120		name='��ġ�ڼ���'		align=center										</C>" +
												"<C> id='RETM_YMD'			width=80		name='��ġ����'			align=center										</C>" +
												"<C> id='UPT_YMD'			width=80		name='��������'			align=center		show=false						</C>" ;

				//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
				//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
				cfStyleGrid(form1.grdT_CM_PERSON,15,"false","false");

            }else if(gbn_case == "J"){  // ������
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='�Ҽ�'				align=center							            </FC>" +
												"<FC> id='JOB_NM'			width=60		name='����'				align=center	    				            	</FC>" +
												"<FC> id='ENO_NO'			width=70		name='���'				align=center		                 				</FC>" +
												"<FC> id='ENO_NM'			width=70		name='����' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='�ٷα���'				align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='�ֹι�ȣ'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='����'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='�б�'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='����'				align=center										</C>" +
												"<C> id='BF_DPT_NM'			width=120		name='�����μ�'			align=center										</C>" +
												"<C> id='ADD_YMD'			width=80		name='�߷���'			align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='�Ի���'			align=center										</C>" +
												"<C> id='RET_YMD'			width=80		name='�����'			align=center										</C>";

				//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
				//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
				cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

            }else if(gbn_case == "K"){  // ������
                form1.grdT_CM_PERSON.Format =   "<C> id='{CUROW}'          width=30        name='NO'                align=center        value={String(Currow)}         </C>" +
                                                "<C> id='DPT_NM'           width=110       name='�Ҽ�'              align=center        suppress = '6'                 </C>" +
                                                "<C> id='JOB_NM'           width=70        name='����'              align=center        suppress = '5'                 </C>" +
                                                "<C> id='ENO_NO'           width=70        name='���'              align=center        suppress = '4'                 </C>" +
                                                "<C> id='ENO_NM'           width=80        name='����'              align=center        suppress = '3'                 </C>" +
                                                "<C> id='HIR_YMD'          width=80        name='�Ի���'            align=center        suppress = '2'                 </C>" +
                                                "<C> id='RET_YMD'          width=80        name='�����'            align=center        suppress = '1'                 </C>" +
                                                "<C> id='STR_YMD'          width=80        name='������'            align=center                                       </C>" +
                                                "<C> id='END_YMD'          width=80        name='������'            align=center                                       </C>" +
                                                "<C> id='REMARK'           width=100       name='����'              align=center                                       </C>";

                //ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
                //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
                cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

             }else if(gbn_case == "L"){  //�ٷα��к�����
                  form1.grdT_CM_PERSON.Format = "<C> id='{CUROW}'          width=30        name='NO'                align=center        value={String(Currow)}         </C>" +
                                                "<C> id='DPT_NM'           width=110       name='�Ҽ�'              align=center                                       </C>" +
                                                "<C> id='JOB_NM'           width=70        name='����'              align=center                                       </C>" +
                                                "<C> id='ENO_NO'           width=70        name='���'              align=center                                       </C>" +
                                                "<C> id='ENO_NM'           width=80        name='����'              align=center                                       </C>" +
                                                "<C> id='HIR_YMD'          width=80        name='�Ի���'            align=center                                       </C>" +
                                                "<C> id='RET_YMD'          width=80        name='�����'            align=center                                       </C>" +
                                                "<C> id='APP_YMD'          width=80        name='�ٷα��к�����'        align=center                                       </C>" +
                                                "<C> id='OCC_CD'           width=180       name='����'              align=center       value={decode(OCC_CD,'A','�ù���->�繫��','M','�繫��->�ù���')}  </C>" ;
                cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

             }else if(gbn_case == "C"){  //������������
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='�Ҽ�'				align=center							            </FC>" +
												"<FC> id='JOB_NM'			width=60		name='����'				align=center	    				            	</FC>" +
												"<FC> id='ENO_NO'			width=70		name='���'				align=center		                 				</FC>" +
												"<FC> id='ENO_NM'			width=70		name='����' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='�ٷα���'				align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='�ֹι�ȣ'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='����'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='�б�'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='����'				align=center										</C>" +
												"<C> id='BF_DPT_NM'			width=120		name='�����μ�'			align=center										</C>" +
												"<C> id='ADD_YMD'			width=80		name='�߷���'			align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='�Ի���'			align=center										</C>" +
												"<C> id='RET_YMD'			width=80		name='�����'			align=center										</C>";

				//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
				//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
				cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");
             }

		}

		/**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtRETM_REM', 'txtRETM_REM_NM');

            fnc_GetUserInfo();
        }

  		/**
         * fnc_GetEnoNm �ٸ������� �������� ������
         */
        function fnc_GetUserInfo() {

            var obj = fnc_GetEnoNm("txtRETM_REM");

            document.getElementById("txtRETM_REM").value = obj.eno_no;
            document.getElementById("txtRETM_REM_NM").value = obj.eno_nm;

        }



		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
 			document.getElementById("cmbRETM_CD").disabled = false;
			document.form1.txtRETM_REM.readOnly = false;
  			document.form1.txtRETM_REM.className = "";
			document.getElementById("imgRETM_REM").disabled = false;
			document.form1.txtRETM_YMD.readOnly = false;
  			document.form1.txtRETM_YMD.className = "";
  			document.getElementById("imgRETM_YMD").disabled = false;
  		}


        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
 			document.getElementById("cmbRETM_CD").disabled = true;
			document.form1.txtRETM_REM.readOnly = true;
  			document.form1.txtRETM_REM.className = "input_ReadOnly";
			document.getElementById("imgRETM_REM").disabled = true;
			document.form1.txtRETM_YMD.readOnly = true;
  			document.form1.txtRETM_YMD.className = "input_ReadOnly";
  			document.getElementById("imgRETM_YMD").disabled = true;
  		}

		/****
		 * ����� ��ġ������ ���� RETM_CD �ڵ��� ���
		 ***********************************************/
		function retminput() {
		    var oTODAY   = getToday();
		    var oTODAY   = oTODAY.replaceStr("-", "/");  //getToday�� ��� "-"�� ��¥ ǥ���Ͽ� ��������.
			var gbn_case = document.form1.hidGBN_GBN_CASE.value;
			var oRETM_CD = document.getElementById("cmbRETM_CD").value;
			var oUPT_YMD = document.getElementById("txtUPT_YMD").value;
			var oTODAY
			if(gbn_case == "R") {

				if(oRETM_CD == "" || oRETM_CD == "1") {
					enableInput();
				} else if(oUPT_YMD == oTODAY) {
					enableInput();
				} else {
					disableInput();
				}
			}
		}

        function fnc_PrintBtn() {
            if(document.getElementById("hidGBN_GBN_CASE").value == "K"||document.getElementById("hidGBN_GBN_CASE").value == "L"||document.getElementById("hidGBN_GBN_CASE").value == "C")
              fnc_HiddenElement("imgPrint");
            else fnc_ShowElement("imgPrint");
        }


    </script>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- ��ġ�ڵ� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_CB"/>
       <jsp:param name="CODE_GUBUN"    value="CB"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)           |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			var gbn_case = document.form1.hidGBN_GBN_CASE.value;

			if(gbn_case == "R"){
	   			enableInput();//�Է��ʵ� Ȱ��ȭ
   			}
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>


    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script language="javascript"  for=dsT_CM_PERSON event=OnRowPosChanged(row)>
		retminput();
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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������ȸ</td>
          <td align="right" class="navigator">HOME/�λ����/�ο�����/<font color="#000000">����������ȸ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="45"></col>
                                <col width="150 "></col>
                                <col width="45 "></col>
                                <col width="70"></col>
                                <col width="45"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�� ��&nbsp;</td>
                                <td class="padding2423" width = "220">
                                    <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                     ~
                                    <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
								<td class="searchState" align="right">�ٷα���&nbsp;</td>
								<td class="padding2423" align="left">
                                    <select id="cmbOCC_CD_SHR" style="width:100%" >
                                        <option value="">��  ��</option>
                                        <option value="A">�繫��</option>
                                        <option value="M">����</option>
                                    </select>
                                </td>
								<td class="searchState" align="right">����&nbsp;</td>
								<td class="padding2423" align="left">
									<input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'H';fnc_ChangeGrid();fnc_PrintBtn();" checked>�Ի���
									<input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'R';fnc_ChangeGrid();fnc_PrintBtn();">�����
									<input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'J';fnc_ChangeGrid();fnc_PrintBtn();">������
                                    <input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'K';fnc_ChangeGrid();fnc_PrintBtn();">������
                                    <input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'L';fnc_ChangeGrid();fnc_PrintBtn();">�ٷα��к�����
                                    <input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'C';fnc_ChangeGrid();fnc_PrintBtn();">������������
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="240"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��ġ����</td>
					<td class="padding2423">
						<select id="cmbRETM_CD" style="width='100'"></select>
					</td>
					<td align="center" class="creamBold">��ġ��</td>
					<td class="padding2423">
						<input id="txtRETM_REM" name="txtRETM_REM" size="10" maxlength="8" onChange="fnc_GetUserInfo();">
						<input id="txtRETM_REM_NM" name="txtRETM_REM_NM" size="15" maxlength="14" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRETM_REM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgRETM_REM" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();"></a>
					</td>
					<td align="center" class="creamBold">��ġ����</td>
					<td class="padding2423">
						<input type="text" id="txtRETM_YMD" name="txtRETM_YMD" style="ime-mode:disabled" style="width:80" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRETM_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgRETM_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtRETM_YMD','','630','152');"></a>
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
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_CM_PERSON">
			                <param name="EdiTABLE"                  value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

<table border="0"><tr><td height="5"></td></tr></table>

<!--************************************************************** ezgen -->
<table border=0>
    <tr height="1">
        <td width="1">
            <table border="00" bordercolordark="white" bordercolorlight="gray" bordercolor="gray">
<!--
                <comment id="__NSID__">
                    <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="1" height="1" codebase="<%=hnwcodebase%>">
                    <param name="hnwsrc"    VALUE="memb100.hnw"
                    <param name="initvalue" VALUE="[:flag]=N">
                    <param name="hidewnd"   VALUE="N">
                    <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
-->
           </table>
        </td>
    </tr>
</table>
<!--************************************************************** ezgen -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" id="biz"  style="display:none">
            <input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            &nbsp;
            <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table>

<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
<input type="hidden" name="hidGBN_OCC_CD" value="A">
<input type="hidden" name="hidGBN_GBN_CASE" value="H">
<input type="hidden" id="txtUPT_YMD" name="txtUPT_YMD">
</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
		<C>Col=RETM_CD     		 	Ctrl=cmbRETM_CD     		 	Param=value 		</C>
		<C>Col=RETM_REM     	 	Ctrl=txtRETM_REM     		 	Param=value 		</C>
		<C>Col=RETM_REM_NM			Ctrl=txtRETM_REM_NM    	 		Param=value	 		</C>
		<C>Col=RETM_YMD				Ctrl=txtRETM_YMD    	 		Param=value	 		</C>
		<C>Col=UPT_YMD				Ctrl=txtUPT_YMD 	   	 		Param=value		 	</C>
    '>
</object>