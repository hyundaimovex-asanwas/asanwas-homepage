<!--
***********************************************************************
* @source      : guna071.jsp
* @description : ������Ȳ ����ó�� - ���缼�λ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      �̵���        ERP �̻�
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���� ����ó�� - ���λ���</title>
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
        
		var obj = new String();
		
		obj.app_cmt = "";
		
		var pis_mm  = "010203";	//�ش�б�
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         *******************************************/
        function fnc_SearchList() {


            //���缼�λ��� ��ȸ(�����û)
            if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
            	
                dsT_DI_CHANGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_01&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
                dsT_DI_CHANGE.reset();
                
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="C"){//���ϱ���
            	
                dsT_DI_CHANGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_02&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO");
                dsT_DI_CHANGE.reset();
				
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){//����������

				var qtr_gbn;

				//������ ��ȸ
	            fnc_SearchApprover();
	            qtr_gbn = dsT_DI_APPROVAL.NameValue(1, "GUN_YMD").substr(4,2);

				if(qtr_gbn == "01") {
				    pis_mm = "010203";
				}else if(qtr_gbn == "04") {
				    pis_mm = "040506";
				}else if(qtr_gbn == "07") {
				    pis_mm = "070809";
				}else if(qtr_gbn == "10") {
				    pis_mm = "101112";
				}

				trT_DI_CHANGE.KeyValue = "JSP( O:dsT_DI_ACCELERATE=dsT_DI_CHANGE,O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY)";
				trT_DI_CHANGE.Action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_ACC&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD")+"&PIS_MM="+pis_mm;
				trT_DI_CHANGE.post();

            }
        }
        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {

            dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN");
            dsT_DI_APPROVAL.Reset();
        }
		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

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

        	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����
        	
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";
			form1.grdT_DI_CHANGE.IgnoreSelectionColor = "true";

            if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                document.getElementById("txtGUN_GBN").value = "���ϱ���";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                document.getElementById("txtGUN_GBN").value = "�����û";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="R"){
                document.getElementById("txtGUN_GBN").value = "��ü�ٹ�";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
                document.getElementById("txtGUN_GBN").value = "�Ϳ�����";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){
                document.getElementById("txtGUN_GBN").value = "����������";
            }

            if(dsTemp.NameValue(1,"APP_TIME")!=""){

			}else{
                document.getElementById("btn_approval").style.display = "";
            }
			if(dsTemp.NameValue(1,"APP_TIME")!=""){
				
				document.getElementById("btn_approval").style.display = "none";
				
			}else{
				
				document.getElementById("btn_approval").style.display = "";
				
			}
			
			// �����ڸ� ��ư�� Ȱ��ȭ
			
            if(dsTemp.NameValue(1,"ENO_NO")!= gusrid){
            	
                document.getElementById("btn_approval").style.display = "none";
                
            }else{

            }

            var nowDate = gcurdate.replace("-","").replace("-","");

            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. �׸��� ���� ó��  *
         ************************/
		function fnc_ChangeGrid() {
        	
			if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=150	name="�Ҽ�"		align=center	</C> '
                							+ '<C> id="JOB_NM"				width=120	name="����"				align=center    </C> '
                							+ '<C> id="ENO_NO"				width=120	name="���"				align=center	</C> '
                							+ '<C> id="ENO_NM"				width=120	name="����"				align=center	</C> '
                							+ '<C> id="GUN_CD"				width=120	name="����"	    		align=center	VALUE={DECODE(GUN_CD,"()","",GUN_CD)}</C>   '
                							+ '<C> id="PIS_YYMMDD"			width=120	name="��������"		align=center	Mask="XXXX-XX-XX"	</C> ';
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=100	name="�Ҽ�"		align=center	</C>  '
                                            + '<C> id="JOB_NM"				width=100	name="����"				align=center    </C>  '
                                            + '<C> id="ENO_NO"				width=70		name="���"				align=center	</C>  '
                                            + '<C> id="ENO_NM"				width=80		name="����"				align=center	</C>  '
                                            + '<G> name="����������"  HeadBgColor="#dae0ee"                       '
											+ '    <C> id="REQ_YMD"	    	width=100	name="������"			align=center Mask="XXXX-XX-XX"  </C> '
                                            + '    <C> id="BF_GUN_CD"		width=100	name="����"				align=center  VALUE={DECODE(BF_GUN_CD,"()","",BF_GUN_CD)}  </C> '
                                            + '</G>'
                                            + '<G> name="�����ı���"  HeadBgColor="#dae0ee"                       '
                                            + '<C> id="GUN_CD"				width=100	name="����"				align=center  VALUE={DECODE(GUN_CD,"()","",GUN_CD)} 	</C>  '
											+ '<C> id="CHN_YMD"	    		width=100	name="������"			align=center  Mask="XXXX-XX-XX" </C> '
                                            + '</G>';
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
				var IndexColCnt     = dsT_DI_CHANGE.CountColumn;       //Į�� �� ����

				// ������ ����Ÿ�¿��� �׸���� ���� ����κ��� ������ �����κ�(��¥) ������ ����
				// Į���Ѱ��� - ���÷����� - ���÷�
				var Dm_ColCnt   = IndexColCnt - 7;
				var req_no = dsTemp.NameValue(1,"REQ_NO");    // ���������� ��


				str_m = (next_month(req_no.substring(0,4)+"-"+req_no.substring(4,6))).substring(5);

				if ( str_m.substr(0,1) == '0' ) {
					str_m = str_m.substr(1,1);
				}


				var str_d;
				var Fix_Col  = "<FC>id={CUROW}	 name=NO             width=30 	align=center               HeadBgColor='#F7DCBB'    value={String(Currow)} </FC>" +
							   "<FC>id=JOB_NM    name=����           width=35   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //1���÷�
							   "<FC>id=ENO_NO    name=���           width=60   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //2���÷�
							   "<FC>id=ENO_NM    name=����           width=60   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //3���÷�
							   "<FC>id=YRP_CNT   name='�߻�;����'    width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" + //4���÷�
							   "<FC>id=NYRP_CNT  name='�̻��;����'  width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" + //5���÷�
							   "<FC>id=REM_CNT   name='�ܿ�'         width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 show=false</FC>" ; //6���÷�

				var Dm_Col = "";   // day �� �ش��ϴ� Į��(���ǿ����� ������ ���ϴ� Į��)

				//**********************     day �� �ش��ϴ� Į�� �� ������ŭ �����Ͽ� grid ������ ����κ��� �����Ѵ�.
				for ( var i = 7; i <= Dm_ColCnt + 6; i++ )
				{
					if ( dsT_DI_CHANGE.ColumnID(i).length == '29' )     // 1~9�����ϰ�� Į�����ڱ��̰� 29 , 11~�ϰ�� Į�����ڱ��̰� 30
					{
						str_d = dsT_DI_CHANGE.ColumnID(i).substr(23,1);
						if ( i == 7 ) 															// ǥ��� ù��
							Dm_Col = Dm_Col + "<G>name="+ str_m +"�� HeadBgColor='#F7DCBB'";
						else if ( dsT_DI_CHANGE.ColumnID(i).substr(23,1) == '1' )
							Dm_Col = Dm_Col + "<G>name="+ ++str_m +"�� HeadBgColor='#F7DCBB'";
						if ( dsT_DI_CHANGE.ColumnID(i+1) == '1' )
							Dm_Col = Dm_Col + "</G>";
					}
					else if (  dsT_DI_CHANGE.ColumnID(i).length == '30' )
					{
						str_d = dsT_DI_CHANGE.ColumnID(i).substr(23,2);
					}

					Dm_Col = Dm_Col + "<C>id='"+dsT_DI_CHANGE.ColumnID(i)+"'  name="+str_d+"  width=25  align=center edit=AlphaUpper show=true Language=0</C> ";
				}

				form1.grdT_DI_CHANGE.Format = Fix_Col + Dm_Col;

           }else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){
			  form1.grdT_DI_CHANGE.Format = "" +
"	<FC> id='{CUROW}'			width=34			name='NO'			align=center			value={String(Currow)}		</FC>	"+
"	<FC> id='DPT_NM'			width=80			name='�Ҽ�'			align=center			Edit=None					</FC>   "+
"	<FC> id='JOB_NM'			width=50			name='����'			align=center			Edit=None					</FC>   "+
"	<FC> id='ENO_NO'			width=60			name='���'			align=center			Edit=None		show=false	</FC>   "+
"	<FC> id='ENO_NM'			width=60			name='����'			align=center			Edit=None					</FC>    "+
"                     <C> id='YRP_CNT'			width=50			name='�� ����'	align=center			Edit=None	DECAO=1					</C>        "+
"                     <C> id='YRP_REM'			width=50			name='�̻��;����'	align=center			Edit=None	DECAO=1				</C>        "+
"                     <C> id='REM_CNT'		    width=40			name='�ܿ�'	        show=false	align=center			Edit=None	DECAO=1			Value={YRP_REM-(ATT_OCT+ATT_NOV+ATT_DEC)}	</C>      "+
"                     <C> id='USE_PER'		    width=40			name='����;����'	    align=center			Edit=None	DECAO=1			Value={ (YRP_CNT - YRP_REM +(ATT_OCT+ATT_NOV+ATT_DEC))/YRP_CNT*100}	</C>      "+
"                     <G>  id='MM_OCT' name='10��'  HeadBgColor='#dae0ee'                                                                                                                              "+
"						  <C> id='AT1_OCT'		width=20		name='1'				align=center			Show=false		</C>                 "+
"						  <C> id='AT2_OCT'		width=20		name='2'				align=center			Show=false		</C>                 "+
"                         <C> id='AT3_OCT'		width=20		name='3'				align=center			Show=false		</C>  				 "+
"						  <C> id='AT4_OCT'		width=20		name='4'				align=center			Show=false		</C>                 "+
"                         <C> id='AT5_OCT'		width=20		name='5'				align=center			Show=false		</C>            	 "+
"						  <C> id='AT6_OCT'		width=20		name='6'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT7_OCT'		width=20		name='7'				align=center			Show=false		</C>                                                                            "+
"						  <C> id='AT8_OCT'		width=20		name='8'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT9_OCT'		width=20		name='9'				align=center			Show=false		</C>                                                                            "+
"						  <C> id='AT10_OCT'		width=20		name='10'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT11_OCT'		width=20		name='11'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT12_OCT'		width=20		name='12'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT13_OCT'		width=20		name='13'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT14_OCT'		width=20		name='14'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT15_OCT'		width=20		name='15'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT16_OCT'		width=20		name='16'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT17_OCT'		width=20		name='17'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT18_OCT'		width=20		name='18'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT19_OCT'		width=20		name='19'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT20_OCT'		width=20		name='20'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT21_OCT'		width=20		name='21'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT22_OCT'		width=20		name='22'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT23_OCT'		width=20		name='23'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT24_OCT'		width=20		name='24'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT25_OCT'		width=20		name='25'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT26_OCT'		width=20		name='26'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT27_OCT'		width=20		name='27'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT28_OCT'		width=20		name='28'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT29_OCT'		width=20		name='29'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT30_OCT'		width=20		name='30'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT31_OCT'		width=20		name='31'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT1_OCT_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_OCT_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"                         <C> id='AT3_OCT_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_OCT_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"                         <C> id='AT5_OCT_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_OCT_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"                         <C> id='AT7_OCT_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_OCT_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"                         <C> id='AT9_OCT_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_OCT_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT11_OCT_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_OCT_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_OCT_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_OCT_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_OCT_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_OCT_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_OCT_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_OCT_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_OCT_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_OCT_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_OCT_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_OCT_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT23_OCT_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT24_OCT_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT25_OCT_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT26_OCT_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT27_OCT_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT28_OCT_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT29_OCT_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT30_OCT_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT31_OCT_V'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"	</G>                                                                                                                                                                                    "+
"                     <G> id='MM_NOV' name='11��'  HeadBgColor='#dae0ee'                                                                                                                              "+
"						  <C> id='AT1_NOV'		width=20		name='1'				align=center			Show=false		</C>                                                                                                  "+
"						  <C> id='AT2_NOV'		width=20		name='2'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT3_NOV'		width=20		name='3'				align=center			Show=false		</C>                                                                            "+
"						  <C> id='AT4_NOV'		width=20		name='4'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT5_NOV'		width=20		name='5'				align=center			Show=false		</C>                                                                            "+
"						  <C> id='AT6_NOV'		width=20		name='6'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT7_NOV'		width=20		name='7'				align=center			Show=false		</C>                                                                            "+
"						  <C> id='AT8_NOV'		width=20		name='8'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT9_NOV'		width=20		name='9'				align=center			Show=false		</C>                                                                            "+
"						  <C> id='AT10_NOV'		width=20		name='10'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT11_NOV'		width=20		name='11'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT12_NOV'		width=20		name='12'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT13_NOV'		width=20		name='13'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT14_NOV'		width=20		name='14'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT15_NOV'		width=20		name='15'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT16_NOV'		width=20		name='16'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT17_NOV'		width=20		name='17'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT18_NOV'		width=20		name='18'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT19_NOV'		width=20		name='19'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT20_NOV'		width=20		name='20'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT21_NOV'		width=20		name='21'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT22_NOV'		width=20		name='22'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT23_NOV'		width=20		name='23'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT24_NOV'		width=20		name='24'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT25_NOV'		width=20		name='25'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT26_NOV'		width=20		name='26'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT27_NOV'		width=20		name='27'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT28_NOV'		width=20		name='28'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT29_NOV'		width=20		name='29'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT30_NOV'		width=20		name='30'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT31_NOV'		width=20		name='31'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT1_NOV_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_NOV_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT3_NOV_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_NOV_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT5_NOV_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_NOV_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT7_NOV_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_NOV_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT9_NOV_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_NOV_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                                             "+
"                         <C> id='AT11_NOV_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_NOV_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_NOV_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_NOV_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_NOV_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_NOV_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_NOV_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_NOV_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_NOV_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_NOV_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_NOV_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_NOV_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>          "+
"                         <C> id='AT23_NOV_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>          "+
"                         <C> id='AT24_NOV_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>          "+
"                         <C> id='AT25_NOV_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>            "+
"                         <C> id='AT26_NOV_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>           "+
"                         <C> id='AT27_NOV_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>           "+
"                         <C> id='AT28_NOV_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>          "+
"                         <C> id='AT29_NOV_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>          "+
"                         <C> id='AT30_NOV_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>            "+
"                         <C> id='AT31_NOV_V'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>            "+
"	</G>                                                                                                                                                "+
"                     <G> id='MM_DEC' name='12��'  HeadBgColor='#dae0ee'                                                                                          "+
"						  <C> id='AT1_DEC'		width=20		name='1'				align=center			Show=false		</C>                                      "+
"						  <C> id='AT2_DEC'		width=20		name='2'				align=center			Show=false		</C>                                            "+
"                         <C> id='AT3_DEC'		width=20		name='3'				align=center			Show=false		</C>                  "+
"						  <C> id='AT4_DEC'		width=20		name='4'				align=center			Show=false		</C>                                        "+
"                         <C> id='AT5_DEC'		width=20		name='5'				align=center			Show=false		</C>                  "+
"						  <C> id='AT6_DEC'		width=20		name='6'				align=center			Show=false		</C>                                       "+
"                         <C> id='AT7_DEC'		width=20		name='7'				align=center			Show=false		</C>                    "+
"						  <C> id='AT8_DEC'		width=20		name='8'				align=center			Show=false		</C>                                    "+
"                         <C> id='AT9_DEC'		width=20		name='9'				align=center			Show=false		</C>                   "+
"						  <C> id='AT10_DEC'		width=20		name='10'				align=center			Show=false		</C>                                    "+
"                         <C> id='AT11_DEC'		width=20		name='11'				align=center			Show=false		</C>                      "+
"                         <C> id='AT12_DEC'		width=20		name='12'				align=center			Show=false		</C>                "+
"                         <C> id='AT13_DEC'		width=20		name='13'				align=center			Show=false		</C>               "+
"                         <C> id='AT14_DEC'		width=20		name='14'				align=center			Show=false		</C>                  "+
"                         <C> id='AT15_DEC'		width=20		name='15'				align=center			Show=false		</C>               "+
"                         <C> id='AT16_DEC'		width=20		name='16'				align=center			Show=false		</C>             "+
"                         <C> id='AT17_DEC'		width=20		name='17'				align=center			Show=false		</C>                "+
"                         <C> id='AT18_DEC'		width=20		name='18'				align=center			Show=false		</C>               "+
"                         <C> id='AT19_DEC'		width=20		name='19'				align=center			Show=false		</C>                  "+
"                         <C> id='AT20_DEC'		width=20		name='20'				align=center			Show=false		</C>                   "+
"                         <C> id='AT21_DEC'		width=20		name='21'				align=center			Show=false		</C>                  "+
"                         <C> id='AT22_DEC'		width=20		name='22'				align=center			Show=false		</C>                     "+
"                         <C> id='AT23_DEC'		width=20		name='23'				align=center			Show=false		</C>                "+
"                         <C> id='AT24_DEC'		width=20		name='24'				align=center			Show=false		</C>                      "+
"                         <C> id='AT25_DEC'		width=20		name='25'				align=center			Show=false		</C>                         "+
"                         <C> id='AT26_DEC'		width=20		name='26'				align=center			Show=false		</C>                       "+
"                         <C> id='AT27_DEC'		width=20		name='27'				align=center			Show=false		</C>                  "+
"                         <C> id='AT28_DEC'		width=20		name='28'				align=center			Show=false		</C>                  "+
"                         <C> id='AT29_DEC'		width=20		name='29'				align=center			Show=false		</C>                  "+
"                         <C> id='AT30_DEC'		width=20		name='30'				align=center			Show=false		</C>                    "+
"                         <C> id='AT31_DEC'		width=20		name='31'				align=center			Show=false		</C>                      "+
"                         <C> id='AT1_DEC_V'	width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>     "+
"						  <C> id='AT2_DEC_V'	width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                         "+
"                         <C> id='AT3_DEC_V'	width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>     "+
"						  <C> id='AT4_DEC_V'	width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                         "+
"                         <C> id='AT5_DEC_V'	width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>     "+
"						  <C> id='AT6_DEC_V'	width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                         "+
"                         <C> id='AT7_DEC_V'	width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"						  <C> id='AT8_DEC_V'	width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                           "+
"                         <C> id='AT9_DEC_V'	width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"						  <C> id='AT10_DEC_V'	width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>                          "+
"                         <C> id='AT11_DEC_V'	width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT12_DEC_V'	width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT13_DEC_V'	width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT14_DEC_V'	width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT15_DEC_V'	width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT16_DEC_V'	width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT17_DEC_V'	width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT18_DEC_V'	width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>      "+
"                         <C> id='AT19_DEC_V'	width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT20_DEC_V'	width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT21_DEC_V'	width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT22_DEC_V'	width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>        "+
"                         <C> id='AT23_DEC_V'	width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT24_DEC_V'	width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT25_DEC_V'	width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT26_DEC_V'	width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT27_DEC_V'	width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT28_DEC_V'	width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT29_DEC_V'	width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT30_DEC_V'	width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"                         <C> id='AT31_DEC_V'	width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>       "+
"	</G>                                                                                                                                                                                    ";
		   }
			cfStyleGrid_New(form1.grdT_DI_CHANGE,15,"false","false");




		}

        /********************************************
         * 17. ����, �Ⱒ ��ư ó��					*
         ********************************************/
		function fnc_Append(yn_var) {

            var msg = "";

			// �����ͼ��� ��� ���� ����.
			dsT_CM_DUMMY.setDataHeader("APP_CMT:STRING, "+		//  ������ �ǰ� Container
																"APP_CMT1:STRING");		// ����
										
			dsT_CM_DUMMY.AddRow();


            if(yn_var == "Y"){
            	
                msg = "����ó����";
                
            }else{
            	
				if(obj.app_cmt == ""){

		            window.showModalDialog("../../../Ehr/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		            if(obj.app_cmt == ""){
		            	
		                    alert("�ΰ� ������ �Է��� ó���ٶ��ϴ�.\n \n�۾��� ��ҵǾ����ϴ�.");
		                    
			            	return false;
			            	
					}
		            
				}
				
                msg = "�ΰ�ó����";
                
            }

			dsT_CM_DUMMY.NameValue(1,"APP_CMT") = obj.app_cmt;   // �����ǰ� Container

            if (confirm(msg+" �Ͻðڽ��ϱ�?")) {

				dsT_DI_CHANGE.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE,I:dsT_CM_DUMMY=dsT_CM_DUMMY)";

				// DPT_CD �������� ����
				
				// ����������  Column�� �����;������� DPT_CD�� �Ȱ�����....
				
				// �׷��� ���������� �ٸ� �μ����� �����ü��� �ְ� �Ͽ���....
				
				 if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
					 
					trT_DI_APPROVAL.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
					
					trT_DI_APPROVAL.post();
					
				 }else{
					 
				 	trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_CM_DUMMY=dsT_CM_DUMMY)";
				 	
					trT_DI_APPROVAL.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&DPT_CD="+dsT_DI_CHANGE.NameValue(1,"DPT_CD");
					
					trT_DI_APPROVAL.post();
					
				 }
				
            }

            window.close();
			
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_CHANGE)		   |
    | 3. ���Ǵ� Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet (���ϳ�¥ ǥ��)     |
    | 2. �̸� : dsT_DI_PLAN04                     |
    | 3. Table List : T_DI_HOLIDAY                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_APPROVAL)	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_PLAN)		|
    | 3. ���Ǵ� Table List(T_DI_PLAN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_CHANGE=T_DI_CHANGE)">
    </Object>
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_CM_DUMMY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
		fnc_ChangeGrid();//�׸��� ���� ó��

		if(dsTemp.NameValue(1,"GUN_GBN")=="A"){
			if(dsT_DI_CHANGE.NameValue(1,"REQ_GBN") >= "2") 	form1.grdT_DI_CHANGE.ColumnProp("10��", "Show") = "false";
			if(dsT_DI_CHANGE.NameValue(1,"END_TAG") == "Y") {
					grdT_DI_CHANGE.ColumnProp("REM_CNT", "show") = "false";
					grdT_DI_CHANGE.ColumnProp("USE_PER", "show") = "false";
			} else {
					grdT_DI_CHANGE.ColumnProp("REM_CNT", "show") = "true";
					grdT_DI_CHANGE.ColumnProp("USE_PER", "show") = "true";
			}
		}else{
            //������ ��ȸ  --  ������������ ��ȸ�� �̹� ���� �Ϸ�Ǿ���.
            fnc_SearchApprover();
        }

	            document.getElementById("txtORD_NO").innerText      = dsT_DI_APPROVAL.NameValue(1, "REQ_NO");
	            document.getElementById("txtENO_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IENO_NM");
	            document.getElementById("txtDPT_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
	            document.getElementById("txtJOB_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IJOB_NM");

            	document.getElementById("btn_approval").style.display = "none";
            	
		        var eno_no = "";
				var app_yn = "";

                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
                	
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//������
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//���翩��

			            //�ش� ������ �ǰ��Է� �غ�.
					if(eno_no == gusrid &&  app_yn == "" ){
						
						document.getElementById("btn_approval").style.display = "";
						
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
						
						break;
					}
                }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">
		if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
			var IndexColCnt     = dsT_DI_CHANGE.CountColumn;       //Į�� �� ����

			// ������ ����Ÿ�¿��� �׸���� ���� ����κ��� ������ �����κ�(��¥) ������ ����
			// Į���Ѱ��� - ���÷����� - ���÷�
			var Dm_ColCnt   = IndexColCnt - 6 - 4;
			//���� ����(�����, �Ͽ���)
			for ( var i = 7; i <= Dm_ColCnt + 6; i++ ){
				if ( dsT_DI_HOLIDAY.NameValue(i-6,"HOL_YN") == "Y" ){
					holiday_color = "#F47380";//����
					form1.grdT_DI_CHANGE.ColumnProp(dsT_DI_CHANGE.ColumnID(i), 'Edit') = 'none';
				}else{
					holiday_color = "#F7DCBB";
					form1.grdT_DI_CHANGE.ColumnProp(dsT_DI_CHANGE.ColumnID(i), 'Edit') = 'AlphaUpper';
				}
				form1.grdT_DI_CHANGE.ColumnProp(dsT_DI_CHANGE.ColumnID(i), 'HeadBgColor') = holiday_color;
			}
		}else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){

					        var pis_yy = dsTemp.NameValue(1,"REQ_NO").substr(0,4);	//�ش�⵵
							var lday = 31;

							grdT_DI_CHANGE.ColumnProp('MM_OCT', 'Name') = pis_mm.substr(0,2) +"��";
							grdT_DI_CHANGE.ColumnProp('MM_NOV', 'Name') = pis_mm.substr(2,2) +"��";
							grdT_DI_CHANGE.ColumnProp('MM_DEC', 'Name') = pis_mm.substr(4,2) +"��";

					            //���� ����(�����, �Ͽ���)
								for(i=1;i<=iCount;i++){
					                grdT_DI_CHANGE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM")+"_V", 'HeadBgColor') = "#F47380";
					            }

							//LAST Day ���� �Ұ� - 1st
					        lday = fnc_Lastday(pis_yy,pis_mm.substr(0,2)) ;
								for(i=lday+1;i<=31;i++){
					                grdT_DI_CHANGE.ColumnProp("AT"+i+"_OCT_V", 'HeadBgColor') = "#F47380";
					            }
							//LAST Day ���� �Ұ� - 2nd
					        lday = fnc_Lastday(pis_yy,pis_mm.substr(2,2)) ;
								for(i=lday+1;i<=31;i++){
					                grdT_DI_CHANGE.ColumnProp("AT"+i+"_NOV_V", 'HeadBgColor') = "#F47380";
					            }
							//LAST Day ���� �Ұ� -3th
					        lday = fnc_Lastday(pis_yy,pis_mm.substr(4,2)) ;
								for(i=lday+1;i<=31;i++){
					                grdT_DI_CHANGE.ColumnProp("AT"+i+"_DEC_V", 'HeadBgColor') = "#F47380";
					            }
		}


    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
        document.getElementById("btn_approval").style.display = "none";
        fnc_SearchApprover();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("../../../Ehr/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ��Է�" ){

		window.showModalDialog("../../../Ehr/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
  </script>
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">


    </Script>

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
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">���� ����ó�� - ���缼�λ���</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35"  width="83" class="searchState" align="center">���±���</td>
			<td  width="120">
			<input id="txtGUN_GBN" size="20"  class="input_ReadOnly" readOnly>
            </td>
			<td height="35" class="paddingTop5" align="right">
                <span id="btn_approval" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">  <img src="../../images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');"></a>&nbsp;&nbsp;
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">  <img src="../../images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');"></a>
                </span>
	            
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->
	
<!-- ���� ����  ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ����� ���� ���� -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="blueBold">ǰ�ǹ�ȣ</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="20" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="blueBold">�Ҽ�</td>
								<td class="padding2423">
                                    <input id="txtDPT_NM" size="20" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">����</td>
								<td class="padding2423">
                                    <input id="txtJOB_NM" size="20" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">�����</td>
								<td class="padding2423">
                                    <input id="txtENO_NM" size="20" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ����� ���� �� -->
        </td>
        <td width="30">&nbsp;&nbsp;&nbsp;</td>
        <td>
        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
            					<C> id='SEQ_NO'		width=50	name='����'		align=center	Value={DECODE(ENO_NO,'100019','����','����')}</C>
								<C> id='ENO_NM'		width=70	name='������'	align=center</C>
								<C> id='JOB_NM'		width=60	name='����'		align=center	</C>
                                <C> id='DPT_NM'		width=100	name='�μ�'		align=left		</C>
								<C> id='APP_YN'		width=160	name='�������'	align=left		Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&APP_YMD} </C>
								<C> id='REMARK1'		width=87	name='�ǰ�'		align=center 	Color='Blue'	</C>
							">
							<param name="wmode" value="transparent" >
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- ���缱 ���� ���̺� �� -->
        </td>
    </tr>
</table>
<!-- ���� ����  �� -->
<br>
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
						<param name="DataID" value="dsT_DI_CHANGE">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- ��ȸ ���� ���̺� ���� -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td colspan = "9" valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						    <tr>
						        <td  align="right" class="searchState" width="100" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:H&nbsp;</td>
						        <td  width="50" bgcolor="#F2AC47"></td>
						        <td  width="50" >&nbsp;</td>
						        <td  align="right" class="searchState" width="100" >���� ����:P&nbsp;</td>
						        <td  width="50" bgcolor="#46B8FF"></td>
						        <td  width="50" >&nbsp;</td>
						        <td  align="right" class="searchState" width="100" >���� ����:R&nbsp;</td>
						        <td  width="50" bgcolor="#80AD80"></td>
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