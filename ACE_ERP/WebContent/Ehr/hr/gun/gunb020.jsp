<!--
*****************************************************
* @source       : gunb020.jsp
* @description : �Ϳ����µ�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/09      ���м�        �����ۼ�.
* 2007/05/11      ���м�        ����
* 2009/11/09      ������        �Ϳ����¿����� ����
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
String DIL_AUTHO = box.getString("SESSION_DIL_AUTHO");
System.out.println("�Ϳ����� ���� [" + DIL_AUTHO + "]");
%>

<html>
<head>
<title>�Ϳ����µ��(gunb020)</title>
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
        var btnList = 'TFTTFFTT';
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var f           = document.form1;
            var str_ymd     = f.txtSTR_YMD_SHR.value;
            var dpt_cd      = f.txtDPT_CD_SHR.value;
            var dpt_nm      = f.txtDPT_NM_SHR.value;
            var eno_no      = f.txtENO_NO_SHR.value;
            var eno_nm      = f.txtENO_NM_SHR.value;

            var holiday_color;
            if ( dpt_nm == "" || dpt_nm == null ) {
                alert("�ҼӸ� �Է��ϼ���.");
                f.txtDPT_CD_SHR.focus();
                return false;
            }
            /*
            if ( eno_no == "" || eno_nm == null ) {
                alert("����� �Է��ϼ���.");
                f.txtDPT_CD_SHR.focus();
                return false;
            }
			*/
            //DS_ONE:�ް� ��ȹ��  DS_TWO:�ش�� ����,�ް� �� DS_FOUR:�޷�(��������)
            trT_DI_PLAN.KeyValue = "JSP(O:DS_ONE=dsT_DI_PLAN, O:DS_TWO=dsT_DI_PLAN02, O:DS_FOUR=dsT_DI_PLAN04, O:DS_FIVE=dsT_DI_APPROVAL)";
            trT_DI_PLAN.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb020.cmd.GUNB020CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
            trT_DI_PLAN.post();

            var IndexColCnt     = dsT_DI_PLAN.CountColumn;       //Į�� �� ����
            // ������ ����Ÿ�¿��� �׸���� ���� ����κ��� ������ �����κ�(��¥) ������ ����
            // Į���Ѱ��� - ���÷����� - ���÷�
            var Dm_ColCnt   = IndexColCnt - 7 ;       
            var str_m = form1.txtSTR_YMD_SHR.value.substr(5,2);    // ���������� ��
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
                           "<FC>id=REM_CNT   name='�ܿ�'         width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" ; //6���÷�

            var Dm_Col = "";   // day �� �ش��ϴ� Į��(���ǿ����� ������ ���ϴ� Į��)
			//**********************     day �� �ش��ϴ� Į�� �� ������ŭ �����Ͽ� grid ������ ����κ��� �����Ѵ�.
			for ( var i = 7; i <= Dm_ColCnt + 6; i++ )
			{
				if ( dsT_DI_PLAN.ColumnID(i).length == '29' )     // 1~9�����ϰ�� Į�����ڱ��̰� 29 , 11~�ϰ�� Į�����ڱ��̰� 30
				{
					str_d = dsT_DI_PLAN.ColumnID(i).substr(23,1);
					if ( i == 7 ) 															// ǥ��� ù��
						Dm_Col = Dm_Col + "<G>name="+ str_m +"�� HeadBgColor='#F7DCBB'";
					else if ( dsT_DI_PLAN.ColumnID(i).substr(23,1) == '1' )
						Dm_Col = Dm_Col + "<G>name="+ ++str_m +"�� HeadBgColor='#F7DCBB'";
					if ( dsT_DI_PLAN.ColumnID(i+1) == '1' )
						Dm_Col = Dm_Col + "</G>";
				}
				else if (  dsT_DI_PLAN.ColumnID(i).length == '30' )
				{
					str_d = dsT_DI_PLAN.ColumnID(i).substr(23,2);
				}
					
				//Dm_Col = Dm_Col + "<C>id='"+dsT_DI_PLAN.ColumnID(i)+"'  name="+str_d+"  width=25  align=center</C> ";
				Dm_Col = Dm_Col + "<C>id='"+dsT_DI_PLAN.ColumnID(i)+"'  name="+str_d+"  width=25  align=center edit=AlphaUpper show=true Language=0</C> ";
			}

            form1.grdT_DI_PLAN.Format = Fix_Col + Dm_Col;

            // �����Է¿Ϸ� ���¿� ����  Grid Style ����(�Ϸ�����ϰ�� ���̻� ���� �Ұ����ϰ� ��Ȱ��ȭ ���ѳ���)
            //�����ڴ� �����ϴ�.
            if (dsT_DI_PLAN.NameValue(1,"END_TAG") != "Y" 
                    || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {
                document.getElementById("imgSave").disabled = false;
                document.getElementById("imgSave").style.display = "";
            
	            //ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
	            //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)            
                cfStyleGrid(form1.grdT_DI_PLAN,15,"true","false");
                
            //�Է¿Ϸ�� �����ڰ� �ƴϸ� ����, �Է¿Ϸ� �ʺ��̰�
            } else {
            
                //��ư�� ��Ȱ��ȭ
                document.getElementById("imgSave").disabled = true;
                document.getElementById("imgSave").style.display = "none";

                cfStyleGrid(form1.grdT_DI_PLAN,15,"false","false");
                
                document.getElementById("resultMessage").innerText = '�Է��� �Ϸ�Ǿ����ϴ�.';
                
            }
            
            //�ش��� ������ �ڷḸ �Է��� �����ϴ�.(�����ڴ� ��� ����)
            var n_month = next_month( getToday().substr(0,7) );

            if ( f.txtSTR_YMD_SHR.value == n_month 
                    || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {
                
                document.getElementById("imgSave").disabled = false;
                document.getElementById("imgSave").style.display = "";
            
                //ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
                //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)            
                cfStyleGrid(form1.grdT_DI_PLAN,15,"true","false");                
                
            }else{

                //��ư�� ��Ȱ��ȭ
                document.getElementById("imgSave").disabled = true;
                document.getElementById("imgSave").style.display = "none";
                
                cfStyleGrid(form1.grdT_DI_PLAN,15,"false","false");
                
                if(dsT_DI_PLAN.NameValue(1,"END_TAG") != "Y"){
                    document.getElementById("resultMessage").innerText = n_month.substring(0,4)+"�� "+n_month.substring(5,7)+'�� �Ϳ����¸� �Է��� �����մϴ�.';
                }
            
            }
            
            
            
            //���� ����(�����, �Ͽ���)
            for ( var i = 7; i <= Dm_ColCnt + 6; i++ ){
                if ( dsT_DI_PLAN04.NameValue(i-6,"HOL_YN") == "Y" ){ 
                    holiday_color = "#F47380";//����
                    form1.grdT_DI_PLAN.ColumnProp(dsT_DI_PLAN.ColumnID(i), 'Edit') = 'none';
                }else{
                    holiday_color = "#F7DCBB";
                    form1.grdT_DI_PLAN.ColumnProp(dsT_DI_PLAN.ColumnID(i), 'Edit') = 'AlphaUpper';
                }
                form1.grdT_DI_PLAN.ColumnProp(dsT_DI_PLAN.ColumnID(i), 'HeadBgColor') = holiday_color;
                
            }
            
            
            //��ȸ���
            f.str_ymd.value = str_ymd;
            
            //�켱 ù��° row�� �հ���� �����ش�.
            fnc_Poschange(1,"JOB_NM")
            
            //form1.grdT_DI_PLAN.SelectionColorProp("FocusEditCol", "BgColor") = "";            
            form1.grdT_DI_PLAN.SelectionColorProp("FocusEditRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.SelectionColorProp("FocusCurCol", "BgColor") = "";
            form1.grdT_DI_PLAN.SelectionColorProp("FocusCurRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.SelectionColorProp("EditCol", "BgColor") = "";
            form1.grdT_DI_PLAN.SelectionColorProp("EditRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.SelectionColorProp("CurCol", "BgColor") = "";
            form1.grdT_DI_PLAN.SelectionColorProp("CurRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.IgnoreSelectionColor = "true";
            
            form1.grdT_DI_PLAN.SelectionColorProp("FocusEditRow", "TextColor") = "#000000";
            form1.grdT_DI_PLAN.SelectionColorProp("FocusCurRow", "TextColor") = "#000000";
            form1.grdT_DI_PLAN.SelectionColorProp("EditRow", "TextColor") = "#000000";
            form1.grdT_DI_PLAN.SelectionColorProp("CurRow", "TextColor") = "#000000";
            
          }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************"C:/project000/MASA(back_up)/�ҽ�/data2/htdocs2/PMSL/js/comFunction.js"
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {
          var f = document.form1;
          if(!fnc_SaveItemCheck()) return;
          str_ymd = f.str_ymd.value;

          trT_DI_PLAN.KeyValue = "tr01(I:dsT_DI_PLAN=dsT_DI_PLAN)";
          trT_DI_PLAN.action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb020.cmd.GUNB020CMD&S_MODE=SAV&STR_YMD="+str_ymd;
          trT_DI_PLAN.post();
          fnc_SearchList();

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

      // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
      // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

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
            
            document.getElementById("imgSave").disabled = false;
            document.getElementById("imgSave").style.display = "";

            
            f.H_val.value = "0";
            f.P_val.value = "0";
            f.R_val.value = "0";
            
            document.getElementById("resultMessage").innerText = ' ';
            dsT_DI_PLAN.ClearAll();            

            document.form1.txtSTR_YMD_SHR.focus();
        
            
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_PLAN.IsUpdated)  {

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

          if (!dsT_DI_PLAN.IsUpdated) {
                    alert("������ �ڷᰡ �����ϴ�.");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                    return false;
          }
          return true;

        }

        function fnc_SaveItemCheck_01() {

            if (!dsT_DI_PLAN_INPUT.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
//                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;
        }

        function fnc_SaveItemCheck_02() {

          if (!dsT_DI_PLAN_UPT.IsUpdated) {
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
			/* �Ϳ����� ����� �Ŵ� 20~ 25�ϱ�������� */
			/* ���´���ڴ�    �Ŵ� 20~ 26�ϱ����� ���*/			
			var todayDD = getToday().substring(8);
			
			if(todayDD <= "20"){
				alert("�Ϳ����´� �Ŵ� 20��~25�� ���̿��� ��밡���մϴ�.");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			}
			
<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M") || box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	
			if(todayDD > "30"){
<%
			}else{
%>
			if(todayDD > "25"){
<%
			}
%>			
			
				alert("�Ϳ����´� �Ŵ� 20��~25�� ���̿��� ��밡���մϴ�.");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			
			}
	        dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// ���³�¥
	                            "GUN_GBN:STRING(1),"+			// ���°��籸��
								"DPT_CD:STRING(3),"+			// ���ºμ�
								"DPT_NM:STRING(10),"+			// ���ºμ���
								"SEQ_NO:STRING(1),"+			// ���缱
								"ENO_NO:STRING(10),"+			// �����ڻ��
								"JOB_CD:STRING(10),"+			// ����������
								"APP_TIME:STRING(10),"+			// ����ð�
								"PENO_NO:STRING(10),"+			// ����ڻ��
								"APP_YN:STRING(10),"+			// ���翩��
								"ENO_NM:STRING(10),"+			// �����ڸ�
								"JOB_NM:STRING(10),"+				// ������
								"REQ_NO:STRING(20)"				// ������
								);



            cfStyleGrid(form1.grdT_DI_PLAN,15,"true","false");

            document.getElementById("txtSTR_YMD_SHR").value = next_month(getToday().substring(0,7)); 
			document.getElementById("txtSTR_YMD_SHR").focus();
            

            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";

            document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.getString("SESSION_ENONM") %>";


<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			 document.getElementById("approval_btn").style.display = "";	   
			 document.getElementById("append_btn").style.display = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
<%//A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			document.getElementById("approval_btn").style.display = "";
			document.getElementById("append_btn").style.display = "";
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
<%
    }else{
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       

			fnc_ChangeStateElement(false, "txtENO_NO_SHR");       
			fnc_ChangeStateElement(false, "txtENO_NM_SHR");       
			fnc_ChangeStateElement(false, "ImgEnoNoSHR");       

			 document.getElementById("approval_btn").style.display = "none";
			 document.getElementById("append_btn").style.display = "none";
<%
	}
%>

			fnc_OnLoadApproval();

         }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

          fnc_HotKey_Process(btnList, event.keyCode);

        }

        function fnc_Poschange(Row,Colid) {//Colid �̻��

            var f = document.form1;
            f.row_num.value = Row;//���� row;
            
            if ( dsT_DI_PLAN02.CountRow > 0 ) {
                // X = ���� �� ���� �� �ް� - ��ȸ�ؿ� �Ⱓ ������ ���� �� �ް�
                //     ( X�� ���ϱ� ����Ÿ�¿� ���� ���� �� �ް��� ���� �� ���� �� �ް��� ǥ����)
                f.H_val_fix.value = dsT_DI_PLAN02.NameValue(Row,"H_1") - dsT_DI_PLAN02.NameValue(Row,"H_2");
                f.P_val_fix.value = dsT_DI_PLAN02.NameValue(Row,"P_1") - dsT_DI_PLAN02.NameValue(Row,"P_2");
                f.R_val_fix.value = dsT_DI_PLAN02.NameValue(Row,"R_1") - dsT_DI_PLAN02.NameValue(Row,"R_2");
            } else {
                f.H_val_fix.value = "";
                f.P_val_fix.value = "";
                f.R_val_fix.value = "";
            }
            var IndexColCnt = dsT_DI_PLAN.CountColumn;       //Į�� �� ����
            var Dm_ColCnt   = IndexColCnt-6;       // ������ ����Ÿ�¿��� �׸���� ���� ����κ��� ������ �����κ�(��¥) ������ ����

            var H_count = 0;  //����Ÿ�¿� ���� ���� �� �ް� ������ ����
            var P_count = 0;
            var R_count = 0;

            for ( var i = 7; i <= Dm_ColCnt + 6; i++ )
            {
                if ( dsT_DI_PLAN.NameValue(Row,dsT_DI_PLAN.ColumnID(i)) == "H" )
                    H_count = H_count + 1;
                else if ( dsT_DI_PLAN.NameValue(Row,dsT_DI_PLAN.ColumnID(i)) == "P" )
                    P_count = P_count + 1;
                else if ( dsT_DI_PLAN.NameValue(Row,dsT_DI_PLAN.ColumnID(i)) == "R" )
                    R_count = R_count + 1;
            }

            f.H_val.value = Number(H_count);
            f.P_val.value = Number(P_count);
            f.R_val.value = Number(R_count);
        }

    /********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

     /********************************************
         * �������ڿ��� ��Ŀ�� ������ ��û���ڿ� ��       		*
         ********************************************/
        function cfCheckDateTermGUNA040(p_obj,p_stdt,p_endt) {
          if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
            if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
              alert("�������ڰ� �������ں��� Ů�ϴ�.");
              document.getElementById(p_obj).value = '';
            }
          }
        }

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNmSHR() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {
			
			if(dsT_DI_PLAN.CountRow < 1){
				alert("���³����� ���� ��ȸ�Ͻʽÿ�.");
				return;
			}
			
            //ds�� ���Ϲ޴´�.
            //fnc_GetApproverDS(dsT_DI_APPROVAL);

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value+"-01";
			var END_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value+"-01";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
			var EMP_NO      = "<%=box.getString("SESSION_ENONO") %>";
			dsT_DI_APPROVAL.DeleteAll();
			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"P");

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();


            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// ���������j �Ϻ� ���¿��� ������ ���� �ʰ� �ϱ����ؼ�...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "P";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("hidREG_NO").value;

            }
        }
        function fnc_OnLoadApproval() {

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_DI_APPROVAL,15,"true","false")      // Grid Style ����
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight   = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }
        function fnc_Report() {
			if(confirm("����Ͻðڽ��ϱ�? �Ϳ����»����� �����Ͻ��Ŀ��� ����� �ݿ��˴ϴ�")){
				var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
				var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
				if(dsT_DI_PLAN.CountRow == 0){
					alert("����� �����͸� ���� ��ȸ�Ͻʽÿ�");
					return;
				}
				if(dsT_DI_APPROVAL.CountRow == 0){
					alert("���缱�� ���� �Ͻʽÿ�");
					return;
				}
				
				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb020.cmd.GUNB020CMD&S_MODE=REP&STR_YMD="+STR_YMD+"&DPT_CD="+DPT_CD;
				trT_DI_APPROVAL.post();
				
			}

        }

       /********************************************
         * form onload��                       			*
         ********************************************/

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------------------------------+
    | 1. ��ȸ�� DataSet (�ް���ȹ�� ��ȸ)                            		                |
    | 2. �̸� : dsT_DI_PLAN                                                 |
    | 3. Table List : T_DI_PLAN, VI_T_CM_PERSON2, T_DI_YEARLY, T_DI_REFRESH |
    +----------------------------------------------------------------------->
    <Object ID="dsT_DI_PLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="Language" value=0>
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet (�⺰ �� ��ȸ�Ⱓ���� ����,�ް��� �հ踦 ��ȸ)    |
    | 2. �̸� : dsT_DI_PLAN02                      |
    | 3. Table List : T_DI_PLAN                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet (�ϰ������� �ߺ��� �������� �����Ǿ��ִ� ��(��)�� ��ȸ)     |
    | 2. �̸� : dsT_DI_PLAN03                     |
    | 3. Table List : T_DI_PLAN                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet (���ϳ�¥ ǥ��)     |
    | 2. �̸� : dsT_DI_PLAN03                     |
    | 3. Table List : T_DI_HOLIDAY                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �Է¿�  DataSet                             |
    | 2. �̸� : dsT_DI_PLAN_INPUT                      |
    | 3. Table List : T_DI_PLAN, VI_T_CM_PERSON, T_DI_HOLIDAY        |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN_INPUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ������  DataSet                             |
    | 2. �̸� : dsT_DI_PLAN_UPT                      |
    | 3. Table List : T_DI_PLAN        |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN_UPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_APPROVAL)			 	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
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

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_PLAN)		|
    | 3. ���Ǵ� Table List(T_DI_PLAN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_PLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


	<!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_APPROVAL)		|
    | 3. ���Ǵ� Table List(T_DI_APPROVAL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_APPROVAL=T_DI_APPROVAL)">
    </Object>
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("����� �Ϸ�Ǿ����ϴ�.");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_PLAN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

          //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");
	dsT_CM_PERSON.DataId="/servlet/GauceChannelSVL?cmd=hr.gun.d.gund020.cmd.GUND020CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
			dsT_CM_PERSON.Reset();

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
          document.form1.grdT_DI_PLAN.focus();
        }
    </Script>
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 1)    {
			document.getElementById("txtDPT_CD_SHR").value = dsT_CM_PERSON.NameValue(1, "GUN_DPT");
			alert("��ȸ ��ư�� �ٽ� �ѹ� Click�Ͽ� �ֽʽÿ�");			
        }

    </Script>
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_PLAN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_PLAN Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {
			document.getElementById("hidREG_NO").value = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
        }else{
			document.getElementById("hidREG_NO").value = "";
		}
		var APP_YN = "";
		for(var i = 1; i <= dsT_DI_APPROVAL.CountRow; i++){
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="Y"){
                APP_YN = "Y";
            }
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="N"){
                APP_YN = "N";
				break
            }
		}
		if(APP_YN=="Y"){
			document.getElementById("save_btn").style.display = "none";		// �����ư
			document.getElementById("append_btn").style.display = "none";	// ��Ź�ư
			document.getElementById("btn_InsDel").style.display = "none";	// ���缱��ư
		}else{

			document.getElementById("save_btn").style.display = "";
		}
    </Script>


    <!--------------------------+
    | Grid �̺�Ʈ ó��  |
    +--------------------------->
    <script language="javascript"  for=grdT_DI_PLAN event=OnColumnPosChanged(Row,Colid)>
         fnc_Poschange(Row,Colid);
    </script>

    <script language="javascript"  for=grdT_DI_PLAN event=onKeyPress(keycode)>
        var form        = document.form1;
        var row_num     = form.row_num.value;
        
        var col_id      = grdT_DI_PLAN.GetColumn();//���� ������ �÷�
        form.col_id.value = col_id;
        
        var temp_val = dsT_DI_PLAN.NameValue(row_num,col_id);

        var NYRP_CNT_TOT = Number(form.H_val.value) + (Number(form.P_val.value)*0.5)  + (Number(form.R_val.value)*0.5)  ;
        
        //�Է¿Ϸ� �����Ұ�(�����ڴ� ����)
        if ( dsT_DI_PLAN.NameValue(row_num,"END_TAG") != "Y" 
                || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {
            
            if ( col_id != "JOB_NM" && col_id != "ENO_NO" && col_id != "ENO_NM" && col_id != "YRP_CNT" && col_id != "NYRP_CNT" && col_id != "REM_CNT" )
            {
                //��밡���� Ű�ڵ�
                //(             H,               P,               R)
                if (keycode == 72 || keycode == 80 || keycode == 82) {
                    //alert(dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") +",  "+ NYRP_CNT_TOT);
                                     
                    //����(H)
                    if ( keycode == "72" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+1 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "H";
                        }
                    //����������(P)
                    } else if ( keycode == "80" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+0.5 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "P";
                        }
                        
                    //���Ŀ�����(R)
                    } else if ( keycode == "82" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+0.5 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "R";
                        }
                        
                    //Ư���ް�(I)
                    } else if ( keycode == "73" ) {
                        form.pre_data.value = "I";   //Ư���ް��� ������ �ƴ�

                    //��ü+������(V)
                    } else if ( keycode == "86" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+0.5 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "V";
                        }
                    }

                } else {
                     form.pre_data.value = "";
                     dsT_DI_PLAN.NameValue(row_num,col_id) = "";
                }
            }
            
        } else {
            alert("�����Է¿Ϸ�� �����Դϴ�. ���� �Ұ����մϴ�.");
            form.pre_data.value = temp_val;//������ ����
        }
        
    </script>

    <script language="javascript"  for=grdT_DI_PLAN event=OnExit(row,colid,olddata)>
    
        var f = document.form1;
        var row_num   = f.row_num.value;//row
        var col_id    = f.col_id.value;//�÷���
        var pre_data  = f.pre_data.value;//�ڵ尪
        //alert("row_num:"+row_num+", col_id:"+col_id+", pre_data:"+pre_data)
        
        if ( col_id != "" || col_id != null){
            dsT_DI_PLAN.NameValue(row_num,col_id) = pre_data;
            
            //�ܿ��� �ٽð��
	        fnc_Poschange(row,colid);
	        dsT_DI_PLAN.NameValue(row_num,"REM_CNT") = Number(dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT")) -
	                                                   (Number(f.H_val.value)      + (Number(f.P_val.value)*0.5) +
	                                                   (Number(f.R_val.value)*0.5) );

        }
        
        //f.row_num.value = row;
        //f.col_id.value = colid;
        //f.pre_data.value = "";

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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<input type="hidden" id="hidREG_NO">
<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ϳ����µ��</td>
          <td align="right" class="navigator">HOME/���°���/�Ϳ�����/<font color="#000000">�Ϳ����µ��</font></td>
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
	<span id="append_btn" style="display:none">
	  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRep','','/images/button/btn_ReportOver.gif',1)">  <img src="/images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Report()"></a>
	</span>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	<span id="save_btn" style="display:none">
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
    </span>
	  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                              <col width="10"></col>
                              <col width="80"></col>
                              <col width="100"></col>
                              <col width="30"></col>
                              <col width="80"></col>
                              <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="center">&nbsp;</td>
                                <td align="right" class="searchState">�ش���&nbsp;</td>
                                <td class="padding2423">
                                    <input type="text" id="txtSTR_YMD_SHR"  name="txtSTR_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','108','113');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="center">&nbsp;</td>
                                <td align="right" class="searchState">�Ҽ�&nbsp;</td>
                                <td class="padding2423"><input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="16" class="input_ReadOnly" readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="center">&nbsp;</td>

							<td class="searchState" align="right">���</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
                        		<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
                        		<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
							</td>


                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div id="approval_btn" style="display:none">
	<!-- ���缱 ���̺� ���� -->
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:112px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'	width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
	            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=96	name='�μ�'		align=center	</C>
									<C> id='JOB_NM'	width=96	name='����'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='���'		align=center	show=false</C>
									<C> id='ENO_NM'	width=100	name='����'		align=center	</C>
									<C> id='APP_YN'	width=100	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')} </C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>

			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td align="right">
	                        <span id="btn_InsDel">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>

	                        </span>
			            </td>
					</tr>
				</table>
			</td>


		</tr>
	</table>
</div>


<!-- power Search���̺� �� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="paddingTop8">
            <table width="800" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" ><span id="resultMessage">&nbsp;</span></td>
                </tr>
             </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="3">
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
            <object	id="grdT_DI_PLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
              <param name="DataID"				value="dsT_DI_PLAN">
              <param name="EdiTABLE"				value="true">
              <param name="DragDropEnable"		value="true">
              <param name="SortView"				value="Left">
              <param name="VIEWSUMMARY"			value=0>
              <param name="Format"				value="
                <FC> id='{CUROW}'		width=30		name=NO				       align=center	       value={String(Currow)}</FC>
                <FC> id='JOB_NM'        width=55     	name='����'		           align=center	        Edit=None	         </FC>
                <FC> id='ENO_NO'		width=50		name='���'		           align=center	        Edit=None	         </FC>
                <FC> id='ENO_NM'		width=50	    name='����'		           align=center      	Edit=None	         </FC>
                <FC> id='YRP_CNT'   	width=40		name='�߻�;����'     	   align=right 		    Edit=None	DECAO=1  </FC>
                <FC> id='NON_CNT'       width=40        name='�̻��;����'         align=right          Edit=none   DECAO=1  </FC>                
                <FC> id='REM_CNT'	    width=40	    name='�ܿ�'                align=right 		    Edit=none	DECAO=1  </FC>

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
<table width="800" border="0" height="20"><tr><td></td></tr></table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="searchState" width="100">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:H&nbsp;</td>
        <td class="searchState" width="100"><input type="text" name="H_val" size="3" readOnly></td>
        <td class="searchState" width="100">���� ������:P&nbsp;</td>
        <td class="searchState" width="100"><input type="text" name="P_val" size="3" readOnly></td>

        <td class="searchState" width="100">���� ������:R&nbsp;</td>
        <td class="searchState" width="100"><input type="text" name="R_val" size="3" readOnly></td>

    </tr>
    <tr>

    </tr>
</table>

<input type="hidden" name="H_val_fix" value="">
<input type="hidden" name="P_val_fix" value="">
<input type="hidden" name="R_val_fix" value="">

<input type="hidden" name="row_num" value="">
<input type="hidden" name="col_id" value="UATT_Z">
<input type="hidden" name="pre_data" value="">

<input type="hidden" name="str_ymd" value="">

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->

