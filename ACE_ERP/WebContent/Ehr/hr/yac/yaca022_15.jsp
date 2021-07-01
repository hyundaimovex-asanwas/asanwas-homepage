<!--*************************************************************************
* @source      : yaca022_15.jsp                                                *
* @description : �ξ簡����� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2014/11/6            �̵���             �����ۼ�                                        *
***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>

<%

 	request.setCharacterEncoding("euc-kr"); 

	//�Ѿ�� ������ ó��
	String TYPE 		= request.getParameter("TYPE");
    String PIS_YY       = request.getParameter("PIS_YY");        
    String ENO_NO       = request.getParameter("ENO_NO");
    String ENO_NM       = request.getParameter("ENO_NM");
    String DPT_NM       = request.getParameter("DPT_NM");
    String JOB_NM       = request.getParameter("JOB_NM");    
    String CET_NO 	    = request.getParameter("CET_NO");            
    String gusrid    	= request.getParameter("gusrid");   
    
 	boolean itMaster = false;     
 
 	//itMaster = true;     
	//���������� �ƴ��� ����
	if(gusrid.equals("6060002")||gusrid.equals("6070001") ) {
		itMaster = true;
	}
	 
%>

<html>
<head>
    <title>�ξ簡�����(yaca022_2015�⵵)</title>
    
    <jsp:include page="/Ehr/common/include/head.jsp"/>  	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
		var opener = window.dialogArguments;

        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "T"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "T"   //����
                    + "T";  //�ݱ�         

        var today = getToday();
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca021.cmd.YACA021CMD";
        var params = null;

        //�Ѿ�� ������ ó��
        var TYPE = "<%=request.getParameter("TYPE") %>";          
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";        
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";           
        var CET_NO = "<%=request.getParameter("CET_NO") %>";    
        var TAX_INCOME = "<%=request.getParameter("TAX_INCOME") %>";
        var gusrid = "<%=request.getParameter("gusrid") %>";         
        var submit = "<%=request.getParameter("END_YN") %>";

        
        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *   OK
         ********************************************/
        function fnc_SearchList() {
        	
            var oPIS_YY = document.getElementById("txtPIS_YY");

            //params = "&S_MODE=SHR_INFO_142"
            params = "&S_MODE=SHR_INFO_15"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&CET_NO="+CET_NO;

            dsT_AC_FAMILY.dataid = dataClassName+params;
            dsT_AC_FAMILY.reset();
            
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                * ING
         ********************************************/
        function fnc_Save() {

            //alert("TAX_INCOME"+TAX_INCOME);
        	
        	if (dsT_AC_FAMILY.CountRow < 1) {
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
            }
            
            

            //�� ��ȿ�� ����
            if(!fnc_SaveItemCheck()) return;

            //checkbox ó��  
            //�⺻����
            if(document.getElementById("chkBAS_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "BAS_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "BAS_MAN") = "";
            
            //�γ���
            if(document.getElementById("chkWCT_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "WCT_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "WCT_MAN") = "";
            
            //�����
            if(document.getElementById("chkTRB_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "TRB_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "TRB_MAN") = "";

            //��ο��
            if(document.getElementById("chkGOL_70").checked == true) dsT_AC_FAMILY.NameValue(1, "GOL_70") = "O";
            else dsT_AC_FAMILY.NameValue(1, "GOL_70") = "";

            //�Ѻθ�
            if(document.getElementById("chkONE_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "ONE_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "ONE_MAN") = "";
            
            //�߰�
            //����Ծ�
            if(document.getElementById("chkINP_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "INP_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "INP_MAN") = "";
            
            //6������
            if(document.getElementById("chkRCH_MAN").checked == true) dsT_AC_FAMILY.NameValue(1, "RCH_MAN") = "O";
            else dsT_AC_FAMILY.NameValue(1, "RCH_MAN") = "";
            
            //TYPE : INS
            //TYPE : UPT
     
            params = "&S_MODE="+TYPE
                   + "_15&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&CET_NO="+CET_NO;
            
            //alert(params);
            //DataSet�� �Է»��·� ����
            dsT_AC_FAMILY.UseChangeInfo = false;
            dsT_AC_FAMILY.UserStatus(1) = 1;

            trT_AC_FAMILY.KeyValue = "TR_INS(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
            trT_AC_FAMILY.action = dataClassName+params;
            
            //prompt('',dsT_AC_FAMILY.text);
            trT_AC_FAMILY.post();           
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {

        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            dsT_AC_FAMILY.ClearData();
            fnc_OnLoadProcess();
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();
        }

        function Juminchk(str) {

			 var num = new Array(13);

			 var digit = new Array(12);
			 var sum = 0;
			 var i=0, j=0;

			 digit[1] = 2;
			 digit[2] = 3;
			 digit[3] = 4;
			 digit[4] = 5;
			 digit[5] = 6;
			 digit[6] = 7;
			 digit[7] = 8;
			 digit[8] = 9;
			 digit[9] = 2;
			 digit[10] = 3;
			 digit[11] = 4;
			 digit[12] = 5;

			 //����� �Է��� �ֹε�� ��ȣ�� �迭�� �ִ´�
			 for(j=1; j<=13; j++) {
			  	num[j] = parseInt(str.charAt(j-1),10)
			 } // for
			 //check_digit�� ��ȣ�� �����Ѵ�
			 for(i=1; i<=12; i++) {
			  	sum += digit[i] * num[i];
			 } // for

			 var div = (sum%11);
			 if(div == 1) {
			  	comp = 0;
			 } else if(div == 0) {
			  	comp = 1;
			 } else if((div != 0)&&(div != 1)) {
			  	comp = 11 - div;
			 } 

			 if(div == 0) {
			  	  if(num[13] == 1) return true;
			  	  else return false;
			 } else if(div == 1) {
				  if(num[13] == 0) return true;
				  else return false;
			 } else if((11-div) == num[13]) {
			  	  return true;
			 } else {
			  	  return false;
			 }

		}

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        function fnRRNCheck(rrn) // ��ȿ���˻�. ����fnRRNCheck("8201011234567");
 		{
			if (fnrrnCheck(rrn) || fnfgnCheck(rrn)) {
		         return true;
     		}

     		return false;

 		}

	 function fnrrnCheck(rrn) // �ֹε�Ϲ�ȣ��ȿ���˻�.
	 {
	     var sum = 0;

	     if (rrn.length != 13) {
	         return false;
	    }
	    else if (rrn.substr(6, 1) != 1 && rrn.substr(6, 1) != 2 && rrn.substr(6, 1) != 3 && rrn.substr(6, 1) != 4) {
		     return false;
	    }

	     for (var i = 0; i < 12; i++) {
	         sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
	     }

	     if (((11 - (sum % 11)) % 10) == Number(rrn.substr(12, 1))) {
	         return true;
	     }

	     return false;
	 }

	function fnfgnCheck(rrn) // �ܱ��ε�Ϲ�ȣ��ȿ���˻�.
	{
		var sum = 0;

	     if (rrn.length != 13) {
	         return false;
	     }
	     else if (rrn.substr(6, 1) != 5 && rrn.substr(6, 1) != 6 && rrn.substr(6, 1) != 7 && rrn.substr(6, 1) != 8) {
	         return false;
	     }

	     if (Number(rrn.substr(7, 2)) % 2 != 0) {
	         return false;
	     }

	     for (var i = 0; i < 12; i++) {
	         sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
	     }

	     if ((((11 - (sum % 11)) % 10 + 2) % 10) == Number(rrn.substr(12, 1))) {
	         return true;
	     }

	     return false;
	 }


        /********************************************
         * 13. ���� ��ȿ�� üũ                        *  ING
         ********************************************/
        function fnc_SaveItemCheck() {

            var cet_no = document.getElementById("txtCET_NO").value;
            var rel_cd = document.getElementById("cmbREL_CD").value;

            var card_amt = Number(form1.txtCARD_AMT_NTS.text) + Number(form1.txtCARD_AMT.text);
            var dir_card_amt = Number(form1.txtDIR_CARD_AMT_NTS.text) + Number(form1.txtDIR_CARD_AMT.text);
            var lh1_amt = Number(form1.txtLH1_AMT_NTS.text) + Number(form1.txtLH1_AMT.text);
            var lh2_amt = Number(form1.txtLH2_AMT_NTS.text) + Number(form1.txtLH2_AMT.text);
            var lh3_amt = Number(form1.txtLH3_AMT_NTS.text) + Number(form1.txtLH3_AMT.text);            
            var lh4_amt = Number(form1.txtLH4_AMT_NTS.text) + Number(form1.txtLH4_AMT.text);
            var lh5_amt = Number(form1.txtLH5_AMT_NTS.text) + Number(form1.txtLH5_AMT.text);
            var lh6_amt = Number(form1.txtLH6_AMT_NTS.text) + Number(form1.txtLH6_AMT.text);
            
            var bir_yy = "";
            var age = "";
            var sex = "";

            var juminno = "";
            juminno = cet_no.substring(0,6) + cet_no.substring(7,14);

            if(fnRRNCheck(juminno) == false){
            	alert("��ȿ���� ���� �ֹι�ȣ�Դϴ�.");
            	return false;
            }

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //�ܱ���
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //�ܱ���
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy); //����
            
            if(rel_cd != "7" && rel_cd != "8" && age > 20 && age < 60 && rel_cd != "0" && rel_cd != "3" && document.getElementById("chkTRB_MAN").checked == false && document.getElementById("chkBAS_MAN").checked == true){
              alert("�⺻���� ����ڰ� �ƴմϴ�."+"\n" + "�⺻���� üũ�� �����Ͻðų� �ڷḦ �����Ͻñ� �ٶ��ϴ�.");
              return false;
            }

            if(rel_cd == "8" && age > 17 && document.getElementById("chkTRB_MAN").checked == false && document.getElementById("chkBAS_MAN").checked == true){
              alert("�⺻���� ����ڰ� �ƴմϴ�."+"\n" + "�⺻���� üũ�� �����Ͻðų� �ڷḦ �����Ͻñ� �ٶ��ϴ�.");
              return false;
            }

            if(document.getElementById("cmbREL_CD").value == ""){
                alert("���谡 �߸��Ǿ����ϴ�.");
                return false;
            }

            //�����ֿ���
            if(TYPE == "UPT" && document.getElementById("cmbREL_CD").value == "0" && form1.radHOL_YN.CodeValue == ''){
				    alert("���� ������ ���θ� üũ �� �ֽʽÿ�..");
			     	return false;
			}
            
            
            //�г����� üũ
            if(TYPE == "UPT" && document.getElementById("cmbREL_CD").value == "0" && form1.radINS_TAG.CodeValue == ''){
				    alert("�г���û���θ� üũ �� �ֽʽÿ�..");
			     	return false;
			}
            

			//�������������ݻ�ȯ�� ������ ���� ������ �����ָ� ����
			if(lh1_amt > 0 && form1.radHOL_YN.CodeValue != 'Y'){
				alert("�������������ݻ�ȯ�� ������ ���� ������ �����ָ� �����մϴ�.");
				return false;
			}

			//���ΰ� �������������ݻ�ȯ�� ������ �ѱ޿����� 30000000�� ���ϸ� ����
			
		
			//if(TAX_INCOME%> >= 50000000 && lh5_amt > 0){
			//	alert("�ѱ޿����� 5000���������� ����� ���Ͽ� ���ΰ� �������������ݻ�ȯ ������ ������ �� �ֽ��ϴ�.");
			//	return false;
			//}
		
			
			//���ΰ� �������������ݻ�ȯ�� ������ ���� ������ �����ָ� ����
			if(lh2_amt > 0 && form1.radHOL_YN.CodeValue != 'Y'){
				alert("���ΰ� �������������ݻ�ȯ�� ������ ���� ������ �����ָ� �����մϴ�.");
				return false;
			}

			
			//������ ������ �ѱ޿����� 30000000�� ���ϸ� ����
			//if(TAX_INCOME%> >= 50000000 && lh6_amt > 0){
			//	alert("�ѱ޿����� 5000���������� ����� ���Ͽ� ������ ������ ������ �� �ֽ��ϴ�.");
			//	return false;
			//}
			
			
			//^^���� �κ��� 2015�� �������� �ٽ� �����ؾ� ��. /////////////////////////////////////////////////////////////////////////////////////////////////////
			
            /* �ð��� ��� ����.
			//��������������Ա����ڻ�ȯ��(30���̻�)>0�̸�1500���� �ʰ��ÿ���
			if(lh6_amt > 15000000){
				alert("��������������Ա����ڻ�ȯ��(30���̻�)>0�̸�1500���� �ʰ��� �� �����ϴ�.");
				return false;
			}
			
			//��������������Ա����ڻ�ȯ��(15��~29��) > 0, ��������������Ա����ڻ�ȯ��(30���̻�)=0�̸� 1000���� �ʰ��� ����
			if(lh5_amt > 10000000 && lh6_amt ==0 ){
				alert("��������������Ա����ڻ�ȯ��(15��~29��) > 0, ��������������Ա����ڻ�ȯ��(30���̻�)=0�̸� 1000���� �ʰ��� �� �����ϴ�.");
				return false;
			}
			
			//��������������Ա����ڻ�ȯ��(15��̸�) > 6000000, ��������������Ա����ڻ�ȯ��(15��~29��)=0, ��������������Ա����ڻ�ȯ��(30���̻�)=0 �̸� 600���� �ʰ��� ����
			if(lh4_amt > 6000000 && lh5_amt == 0 && lh6_amt == 0){
				alert("��������������Ա����ڻ�ȯ��(15��̸�) > 0, ��������������Ա����ڻ�ȯ��(15��~29��)=0, ��������������Ա����ڻ�ȯ��(30���̻�)=0 �̸� 600������ �ʰ��� �� �����ϴ�.");
				return false;
			}
			*/
			
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            //��ֿ��� cmbINV_MAN
            if(document.getElementById("chkTRB_MAN").checked == true && document.getElementById("cmbINV_MAN").value == '0'){
				    alert("��� ���θ� üũ �� �ֽʽÿ�");
			     	return false;
			}else if(document.getElementById("chkTRB_MAN").checked != true && document.getElementById("cmbINV_MAN").value != '0'){
				    alert("��� ���θ� Ȯ���� �ֽʽÿ�");
			     	return false;				
			}			

            
            //�ݾ�üũ 
            //1. �γ��� ����  - �ٷμҵ�ݾ� 3õ��������
            //2. �����������Ա�(������) - �ѱ޿� 5õ��������
            //3. ���ø�������ҵ���� - �ѱ޿� 7��������
            //4. ������������������� - �ѱ޿� 8õ��������(��������)
            //5. �ſ�ī�� - �ѱ޿��� 25% �ʰ� 
            //5. �Ƿ��  - �ѱ޿�  3% �ʰ�
            //6. ������ - �ѱ޿� 7õ���� ���� 
            
            
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
            
            
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
        	
        	dsT_AC_FAMILY.ClearData();

            form1.txtLH1_AMT.Enable = "false";    // �����ڱ� ��Ȱ��ȭ
            form1.txtLH2_AMT.Enable = "false";
            form1.txtLH3_AMT.Enable = "false";
            form1.txtLH4_AMT.Enable = "false";
            form1.txtLH5_AMT.Enable = "false";
            form1.txtLH6_AMT.Enable = "false";
            form1.txtLH7_AMT.Enable = "false";
            form1.txtLH8_AMT.Enable = "false";
            form1.txtLH9_AMT.Enable = "false";
            form1.txtLH10_AMT.Enable = "false";
            form1.txtLH11_AMT.Enable = "false";
            form1.txtLH12_AMT.Enable = "false";
            
            form1.txtLH1_AMT_NTS.Enable = "false";
            form1.txtLH2_AMT_NTS.Enable = "false";
            form1.txtLH3_AMT_NTS.Enable = "false";
            form1.txtLH4_AMT_NTS.Enable = "false";
            form1.txtLH5_AMT_NTS.Enable = "false";
            form1.txtLH6_AMT_NTS.Enable = "false";
            form1.txtLH7_AMT_NTS.Enable = "false";
            form1.txtLH8_AMT_NTS.Enable = "false";
            form1.txtLH9_AMT_NTS.Enable = "false";
            form1.txtLH10_AMT_NTS.Enable = "false";
            form1.txtLH11_AMT_NTS.Enable = "false";
            form1.txtLH12_AMT_NTS.Enable = "false";
            
            //�����ڵ� ��������
            
            var oSelect = document.getElementById("cmbREL_CD");
            var oOption = null;

            for(var i=oSelect.length-1; i>0; i--) {
                oSelect.remove(i);
            }
            
            for(var i=1; i<=dsT_CM_COMMON_FA.CountRow; i++) {
                oOption = document.createElement("option");
                oOption.value = dsT_CM_COMMON_FA.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FA.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }
    
            form1.txtMARKET_AMT.Enable = "false";
            fnc_Card_Setting("9");
            
            
            //�Է� ���°� �������� ����
            if(TYPE == "INS") {
                //DS ��� ����
                dsT_AC_FAMILY.setDataHeader(  "REL_CD:STRING"
                                            +",NAM_KOR:STRING"
                                            +",CET_NO:STRING"
                                            +",BAS_MAN:STRING"
                                            +",GOL_70:STRING"
                                            +",WCT_MAN:STRING"
                                            +",TRB_MAN:STRING"
                                            +",INV_MAN:STRING"                                            
                                            +",ONE_MAN:STRING"  
                                            +",INP_MAN:STRING"  
                                            +",RCH_MAN:STRING"               
                                            +",EDU_TAG:STRING"
                               
                                            +",LIN_AMT_NTS:INT"
                                            +",LIH_AMT_NTS:INT"
                                            +",MED_AMT_NTS:INT"
                                            +",LEN_AMT_NTS:INT"
                                            +",EDU_AMT_NTS:INT"
                                            +",HED_AMT_NTS:INT"
                                            +",CARD_AMT_NTS:INT"
                                            +",DIR_CARD_AMT_NTS:INT"
                                            +",MARKET_AMT_NTS:INT"                                            
                                            +",CASH_AMT_NTS:INT"
                                            +",PUBLIC_AMT_NTS:INT"
                                            
                                            +",LIN_AMT:INT"
                                            +",LIH_AMT:INT"
                                            +",MED_AMT:INT"
                                            +",LEN_AMT:INT"
                                            +",EDU_AMT:INT"
                                            +",HED_AMT:INT"
                                            +",CARD_AMT:INT"
                                            +",DIR_CARD_AMT:INT"
                                            +",MARKET_AMT:INT"
                                            +",CASH_AMT:INT"
                                            +",PUBLIC_AMT:INT"
                                            
                                            +",CARD_2013_AMT:INT"                                            
                                            +",CARD_2014_AMT:INT"
                                            +",CARD_2013_OVER:INT"
                                            +",CARD_2014_OVER:INT"   
                                            +",CARD_2015_AMT:INT"   
                                            +",CARD_2015_FH_OVER:INT"   
                                            +",CARD_2015_SH_OVER:INT"   

                                            +",LH1_AMT:INT"                                            
                                            +",LH2_AMT:INT"
                                            +",LH3_AMT:INT"
                                            +",LH4_AMT:INT"
                                            +",LH5_AMT:INT"
                                            +",LH6_AMT:INT"
                                            +",LH7_AMT:INT"
                                            +",LH8_AMT:INT"     
                                            +",LH9_AMT:INT"     
                                            +",LH10_AMT:INT"     
                                            +",LH11_AMT:INT"     
                                            +",LH12_AMT:INT"     
                                            
                                            +",LH1_AMT_NTS:INT"
                                            +",LH2_AMT_NTS:INT"
                                            +",LH3_AMT_NTS:INT"
                                            +",LH4_AMT_NTS:INT"
                                            +",LH5_AMT_NTS:INT"
                                            +",LH6_AMT_NTS:INT"
                                            +",LH7_AMT_NTS:INT"
                                            +",LH8_AMT_NTS:INT"
                                            +",LH9_AMT_NTS:INT"
                                            +",LH10_AMT_NTS:INT"
                                            +",LH11_AMT_NTS:INT"
                                            +",LH12_AMT_NTS:INT"
                                            
                                            +",SAJU_AMT_NTS:INT"  
                                            +",SAJU_AMT:INT"                                             
                                            
                                           );

                dsT_AC_FAMILY.AddRow();

                //������ disable ��Ű��
                changeEduTag("");

                //���躯���
                changeRelTag("");

                //����ΰ���
                fnc_changeTrbManDisabled();

            } else if(TYPE == "UPT"){
                //�׸� ������ ��� �ش� �׸��� ��ȸ�� ��
                fnc_SearchList();
            }
            
		    if(submit=='Y' )
            {
	            alert("���������ϼ̽��ϴ�.");			    		    	
        		fnc_disableInput();

            }         
            
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * 17. �Է��ʵ� ��� �Ұ����ϰ�(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

        	
            form1.txtLIN_AMT_NTS.Enable = "false";    
            form1.txtLIN_AMT.Enable = "false";
            form1.txtLIH_AMT_NTS.Enable = "false";
            form1.txtLIH_AMT.Enable = "false";
            
            
            form1.txtEDU_AMT_NTS.Enable = "false";
            form1.txtEDU_AMT.Enable = "false";    
            form1.txtHED_AMT_NTS.Enable = "false";
            form1.txtHED_AMT.Enable = "false";
         	
        	
            form1.txtCARD_AMT_NTS.Enable = "false";    
            form1.txtDIR_CARD_AMT_NTS.Enable = "false";
            form1.txtCASH_AMT_NTS.Enable = "false";
            form1.txtMARKET_AMT_NTS.Enable = "false";
            form1.txtPUBLIC_AMT_NTS.Enable = "false";
            form1.txtCARD_AMT.Enable = "false";    
            form1.txtDIR_CARD_AMT.Enable = "false";
            form1.txtCASH_AMT.Enable = "false";
            form1.txtMARKET_AMT.Enable = "false";
            form1.txtPUBLIC_AMT.Enable = "false";            
            
            form1.txtCARD_2013_AMT.Enable = "false";    
            form1.txtCARD_2014_AMT.Enable = "false";
            form1.txtCARD_2013_OVER.Enable = "false";
            form1.txtCARD_2014_OVER.Enable = "false";   
            
            form1.txtCARD_2015_AMT.Enable = "false";   
            form1.txtCARD_2015_FH_OVER.Enable = "false";   
            form1.txtCARD_2015_SH_OVER.Enable = "false";   
          
            form1.txt_CARD_DUMMY1.Enable = "false";    
            form1.txt_CARD_DUMMY2.Enable = "false";
            form1.txt_CARD_DUMMY3.Enable = "false";
            form1.txt_CARD_DUMMY4.Enable = "false";
            form1.txt_CARD_DUMMY5.Enable = "false";
            form1.txt_CARD_DUMMY6.Enable = "false";
            form1.txt_CARD_DUMMY7.Enable = "false";
            
            form1.txtLH1_AMT.Enable = "false";    // �����ڱ� ��Ȱ��ȭ
            form1.txtLH2_AMT.Enable = "false";
            form1.txtLH3_AMT.Enable = "false";
            form1.txtLH4_AMT.Enable = "false";
            form1.txtLH5_AMT.Enable = "false";
            form1.txtLH6_AMT.Enable = "false";
            form1.txtLH7_AMT.Enable = "false";
            form1.txtLH8_AMT.Enable = "false";
            form1.txtLH9_AMT.Enable = "false";
            form1.txtLH10_AMT.Enable = "false";
            form1.txtLH11_AMT.Enable = "false";
            form1.txtLH12_AMT.Enable = "false";
            
            form1.txtLH1_AMT_NTS.Enable = "false";
            form1.txtLH2_AMT_NTS.Enable = "false";
            form1.txtLH3_AMT_NTS.Enable = "false";
            form1.txtLH4_AMT_NTS.Enable = "false";
            form1.txtLH5_AMT_NTS.Enable = "false";
            form1.txtLH6_AMT_NTS.Enable = "false";
            form1.txtLH7_AMT_NTS.Enable = "false";
            form1.txtLH8_AMT_NTS.Enable = "false";
            form1.txtLH9_AMT_NTS.Enable = "false";
            form1.txtLH10_AMT_NTS.Enable = "false";
            form1.txtLH11_AMT_NTS.Enable = "false";
            form1.txtLH12_AMT_NTS.Enable = "false";

            form1.txtSAJU_AMT_NTS.Enable = "false";
            form1.txtSAJU_AMT.Enable = "false";            
            
            document.getElementById("chkBAS_MAN").disabled = true;
            document.getElementById("chkGOL_70").disabled = true;
            document.getElementById("chkTRB_MAN").disabled = true;
            document.getElementById("chkWCT_MAN").disabled = true;
            document.getElementById("chkONE_MAN").disabled = true;      
            document.getElementById("radHOL_YN").disabled = true;
            form1.radHOL_YN.Enable = "false";            
            document.getElementById("radINS_TAG").disabled = true;
            form1.radINSL_TAG.Enable = "false";            
  			document.getElementById("btnPRO_PERSON").disabled = true;
  			document.getElementById("btnPRO_RENT").disabled = true; 
  			document.getElementById("btnPDF_Upload").disabled = true;
  			
  			document.getElementById("chkINP_MAN").disabled = true;      
  			document.getElementById("chkRCH_MAN").disabled = true;      
  			
  			

            fnc_HiddenElement("imgSave");
            
  		}        
        
        
        /********************************************
         * 18. ���ΰ� �����������Ա� ������ ��ȯ�� �ҵ���� ���� �ۼ�*
         ********************************************/        
        function fnc_RegPerson(){

        	if (dsT_AC_FAMILY.IsUpdated)  {
        		
        		if (confirm("�Էµ� �ڷᰡ �ֽ��ϴ�. \n\n������ ���� �Ͻñ� �ٶ��ϴ�."))
        			return false;
        		
        	}else{        	
        		    //var href_page = "yaca022_person_14.jsp"
            		var href_page = "yaca022_person_15.jsp"
                          + "?PIS_YY="+PIS_YY
  		                + "&ENO_NO="+ENO_NO
		                + "&ENO_NM="+ENO_NM
		                + "&DPT_NM="+DPT_NM
		                + "&JOB_NM="+JOB_NM;                       

            window.showModalDialog(href_page, "", "dialogWidth:860px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            
            fnc_SearchList();    
        	
        	}

        }        
        
        /********************************************
         * 19. ������ �ҵ���� ���� �ۼ�                                              *
         ********************************************/        
        function fnc_RegRent(){
        	
        	if (dsT_AC_FAMILY.IsUpdated)  {
        		
        		if (confirm("�Էµ� �ڷᰡ �ֽ��ϴ�. \n\n������ ���� �Ͻñ� �ٶ��ϴ�."))
        			return false;
        		
        	}else{
        	
            	//var href_page = "yaca022_rent_14.jsp"
            	var href_page = "yaca022_rent_15.jsp"
		                + "?PIS_YY="+PIS_YY
		                + "&ENO_NO="+ENO_NO
		                + "&ENO_NM="+ENO_NM
		                + "&DPT_NM="+DPT_NM
		                + "&JOB_NM="+JOB_NM;                          

  			window.showModalDialog(href_page, "", "dialogWidth:860px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
  			
            fnc_SearchList();
            
        	}

        }              
        
        /********************************************
         * 20. �ſ�ī�� ����                                            *
         ********************************************/        
        function fnc_Alert1(){        
            alert("2013.1.1��2013.12.31.���� ������ ����� \n�ſ�ī��, ���ݿ�����, ����ī�������ī�� ��ü ���� ");
        }           
        
        function fnc_Alert2(){             
            alert("2014.1.1��2014.12.31.���� ������ ����� \n�ſ�ī��, ���ݿ�����, ����ī�������ī�� ��ü ���� ");
        }         

        function fnc_Alert3(){        
            alert("�ſ�ī�� ������ ������ 2013.1.1.��2013.12.31.���� ������ �����\n�����������߱�������ݿ�����������/����ī��(�߰������� ����)\n������ �հ�� �Է� -> 30% ������ ��� ������ ");
        }         
        
        function fnc_Alert4(){                   
            alert("�ſ�ī�� ������ ������ 2015.1.1.��2015.6.30.����\n������ ����� �����������߱�������ݿ�����������/����ī��\n(�߰������� ����) ������ �հ�� �Է�\n-> 30% ������ ��� ������ ");
        }   
        
		function fnc_Alert5(){        
            alert("2015.1.1.��2015.12.31.���� ������ ����� \n�ſ�ī������߱�������ݿ�����������/����ī�� ��ü ���� ");
        }   
		        
		function fnc_Alert6(){        
		    alert("�ſ�ī�� ������ ������ 2014.1.1.��2014.12.31.����\n������ ����� �����������߱�������ݿ�����������/����ī��\n(�߰������� ����) ������ �հ�� �Է�\n-> 30% ������ ��� ������ ");
		}   
		
		function fnc_Alert7(){        
		    alert("�ſ�ī�� ������ ������ 2015.7.1.��2015.12.31.����\n������ ����� �����������߱�������ݿ�����������/����ī��\n(�߰������� ����) ������ �հ�� �Է�\n-> 30% ������ ��� ������ ");
		}   
        
        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array( "txtNAM_KOR"
                                     ,"txtCET_NO");

        //�׸���� �޼���
        var oElementMsgList = new Array( "����"
                                        ,"�ֹι�ȣ");

        //���� �׸��
        var oExceptionList = new Array(  );

        /**
         * �ֹι�ȣ ����
         */
        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("�߸��� �ֹι�ȣ�Դϴ�. Ȯ�ιٶ��ϴ�.");
                    return false;
                }
            }

            return true;
        }

        /**
         * ���������� ���� �ɶ�
         */
        function changeEduTag(selVal) {

            if(selVal == "") {
                form1.txtEDU_AMT_NTS.text = "0";
                form1.txtEDU_AMT.text = "0";

                form1.txtEDU_AMT_NTS.Enable = "false";
                form1.txtEDU_AMT.Enable = "false";
            } else {
                form1.txtEDU_AMT_NTS.Enable = "true";
                form1.txtEDU_AMT.Enable = "true";
            }

        }

        /**
         * ���谡 ���� �ɶ�
         */
        function changeRelTag(selVal) {

            document.getElementById("chkBAS_MAN").checked = false;
            document.getElementById("chkGOL_70").checked  = false;
            document.getElementById("chkTRB_MAN").checked = false;
            document.getElementById("chkWCT_MAN").checked = false;
            document.getElementById("chkONE_MAN").checked = false;
            
            document.getElementById("chkINP_MAN").checked = false;
            document.getElementById("chkRCH_MAN").checked = false;
            document.getElementById("radHOL_YN").disabled = true;
            document.getElementById("radINS_TAG").disabled = true;
            
            

            if(selVal == ""){

            }else if(selVal == "0"){//����
                alert("�����ڷᰡ �̹� ��ϵǾ� �ֽ��ϴ�.");

                changeRelDisabled("");

                return false;


            }else if(selVal == "1"){//�ҵ����� ��������

            }else if(selVal == "2"){//������� ��������

            }else if(selVal == "3"){//�����
            	
                //document.getElementById("chkBAS_MAN").checked = true;

            }else if(selVal == "4"){//������

            }else if(selVal == "5"){//������

            }else if(selVal == "6"){//�����ڸ�

            }else if(selVal == "7"){//������

            }else if(selVal == "8"){//��Ź�Ƶ�

			}

            changeRelDisabled(selVal);

        }

        //�ֹι�ȣ üũ
        function changeCetTag() {

            var rel_cd = document.getElementById("cmbREL_CD").value;
            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //�ܱ���
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //�ܱ���
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy);//����
            
            
            //alert("age::"+age);

            document.getElementById("chkGOL_70").checked = false;
            document.getElementById("chkWCT_MAN").disabled = true;


            if(rel_cd == "0"){//����

                if( cet_no != null && cet_no != "" &&
                   (cet_no.substring(7,8) == "2" || cet_no.substring(7,8) == "4" || cet_no.substring(7,8) == "6" || cet_no.substring(7,8) == "8") ){
                    document.getElementById("chkWCT_MAN").disabled = false;//Ȱ��ȭ�Ѵ�.
                }else{
                    document.getElementById("chkWCT_MAN").checked = false;//�����ΰ�� ������ üũ ���ϰ�
                }

            }else if(rel_cd == "1"){//�ҵ����� ��������
                if(age <= 28){
                    alert("��������(���θ�/�θ�) ���� ��ǿ� �ش����� �ʽ��ϴ�.");

                    return false;
                }

                //�⺻����
                if(age >= 60){
                    document.getElementById("chkBAS_MAN").checked = true;
                    form1.txtLIN_AMT_NTS.Enable = "true";
                    form1.txtLIN_AMT.Enable = "true";
                }else{
                    document.getElementById("chkBAS_MAN").checked = false;
                    form1.txtLIN_AMT_NTS.Enable = "false";
                    form1.txtLIN_AMT.Enable = "false";

                    form1.txtLIN_AMT.text=0;
 	                form1.txtLIN_AMT_NTS.text=0;
                }

                if(age >= 70){//���(70���̻�)
                    document.getElementById("chkGOL_70").checked = true;
                }

            }else if(rel_cd == "2"){//������� ��������
                if(age <= 28){
                    alert("��������(���θ�/�θ�) ���� ��ǿ� �ش����� �ʽ��ϴ�.");

                    return false;
                }

                //�⺻����
                if(age >= 60){
                    document.getElementById("chkBAS_MAN").checked = true;
                }else{
                    document.getElementById("chkBAS_MAN").checked = false;
                }

                if(age >= 70){//���(70���̻�)
                    document.getElementById("chkGOL_70").checked = true;
                }

            }else if(rel_cd == "3"){    //�����

            }else if(rel_cd == "4"){    //������
                if(age > 20){
                    alert("������ ���� ��ǿ� �ش����� �ʽ��ϴ�.\n���� �� �ֹι�ȣ�� Ȯ���ϼ���");

                    return false;
                }else{
                    document.getElementById("chkBAS_MAN").checked = true;
                }

            }else if(rel_cd == "5"){    //������ �ڳ��
                if(age > 20){
                    alert("������ �ڳ�� ���� ��ǿ� �ش����� �ʽ��ϴ�.\n���� �� �ֹι�ȣ�� Ȯ���ϼ���");

                    return false;
                }else{
                    document.getElementById("chkBAS_MAN").checked = true;
                }

            }else if(rel_cd == "6"){//�����ڸ�
            	
            	 if(age>20 && age<60){
                     alert("�����ڸ��� ���� ��ǿ� �ش����� �ʽ��ϴ�.\n���� �� �ֹι�ȣ�� Ȯ���ϼ���");
                     return false;
                 }else{
                     document.getElementById("chkBAS_MAN").checked = true;
                 }
            
            }else if(rel_cd == "7"){//������

               document.getElementById("chkBAS_MAN").checked = true;
            }
 			else if(rel_cd == "8"){//��Ź�Ƶ�

 				 if(age>=18){
                     alert("��Ź�Ƶ� ���� ��ǿ� �ش����� �ʽ��ϴ�.\n���� �� �ֹι�ȣ�� Ȯ���ϼ���");
                     return false;
                 }else{
                     document.getElementById("chkBAS_MAN").checked = true;
                 }	
            }
        }

        //�⺻���� Ŭ���ÿ���
        function fnc_chkBasMan(){

            var rel_cd = document.getElementById("cmbREL_CD").value;
            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //�ܱ���
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //�ܱ���
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

            age = Number(PIS_YY) - Number(bir_yy);//����

            if(document.getElementById("chkBAS_MAN").checked == false){//�⺻������ �ʵǸ� �ʵȴ�.
                document.getElementById("chkTRB_MAN").checked = false;
                document.getElementById("chkGOL_70").checked = false;
                document.getElementById("chkONE_MAN").checked = false;                
            }

            if(rel_cd == "1" && document.getElementById("chkBAS_MAN").checked == true){//�ҵ����� ��������(�⺻���� üũ�Ǿ�����)
                if(age >= 60){
                    //document.getElementById("chkBAS_MAN").checked = true;//�̹� üũ

	                if(age >= 70){//���(70���̻�)
	                   document.getElementById("chkGOL_70").checked = true;
	                }

                }else{
                    if(document.getElementById("chkTRB_MAN").checked != true){//����ΰ��� ����
	                    alert("�⺻���� ����ڰ� �ƴմϴ�.");
	                    document.getElementById("chkBAS_MAN").checked = false;
	                    return false;
	                }
                }

            }else if(rel_cd == "2" && document.getElementById("chkBAS_MAN").checked == true){//������� ��������(�⺻���� üũ�Ǿ�����)
                if(age >= 60){
                    //document.getElementById("chkBAS_MAN").checked = true;//�̹� üũ

                    if(age >= 70){//���(70���̻�)
                      document.getElementById("chkGOL_70").checked = true;
                    }

                }else{
                    if(document.getElementById("chkTRB_MAN").checked != true){//����ΰ��� ����
	                    alert("�⺻���� ����ڰ� �ƴմϴ�.");
	                    document.getElementById("chkBAS_MAN").checked = false;
	                    return false;
	                }
                }

            }

            if(rel_cd == "4" || rel_cd == "5" || rel_cd == "6"){
              if(age >= 21 && age <= 59 && document.getElementById("chkTRB_MAN").checked != true){
                 alert("�⺻���� ����ڰ� �ƴմϴ�.");
	             document.getElementById("chkBAS_MAN").checked = false;
	             return false;
              }
            }

            //�⺻���� ����ڰ� �ƴϸ� ����� �Է� ���Ѵ�.
            if(document.getElementById("chkBAS_MAN").checked == true){
                    form1.txtLIN_AMT_NTS.Enable = "true";
                    form1.txtLIN_AMT.Enable = "true";
            }else{
                    form1.txtLIN_AMT_NTS.Enable = "false";
                    form1.txtLIN_AMT.Enable = "false";

                    form1.txtLIN_AMT_NTS.text = 0;
                    form1.txtLIN_AMT.text = 0;
            }

	        if(rel_cd == "3"){
	            //����� �⺻���� ����
	            fnc_changeBasManDisabled();

            }else if(rel_cd == "4" && document.getElementById("chkBAS_MAN").checked == true){//������

            }else if(rel_cd == "5" && document.getElementById("chkBAS_MAN").checked == true){//������ �ڳ��

            }else if((rel_cd == "0" || rel_cd == "3" || rel_cd == "4" || rel_cd == "5" ) && document.getElementById("chkTRB_MAN").checked == true){

            }
            else {

            }

       }

        // ����� �⺻���� Ŭ��, ��ȸ, �ű�
        function fnc_changeBasManDisabled(){

            var rel_cd = document.getElementById("cmbREL_CD").value;
            
            if(rel_cd == "3"){
                if(document.getElementById("chkBAS_MAN").checked == true){//�����

                    document.getElementById("cmbEDU_TAG").disabled = false;

                    form1.txtCARD_AMT_NTS.Enable = "true";
                    form1.txtCARD_AMT.Enable = "true";
                    
                    form1.txtDIR_CARD_AMT_NTS.Enable = "true";
                    form1.txtDIR_CARD_AMT.Enable = "true";
                    
                    form1.txtCASH_AMT_NTS.Enable = "true";
                    form1.txtCASH_AMT.Enable = "true";
                    
                    form1.txtMARKET_AMT_NTS.Enable = "true";
                    //form1.txtMARKET_AMT.Enable = "true";
                    
                    form1.txtPUBLIC_AMT_NTS.Enable = "true";
                    form1.txtPUBLIC_AMT.Enable = "true";
                    
                    //form1.txtCARD_2013_AMT.Enable = "true";    
                    //form1.txtCARD_2014_AMT.Enable = "true";
                    //form1.txtCARD_2013_OVER.Enable = "true";
                    //form1.txtCARD_2014_OVER.Enable = "true";                          

                    form1.txtCARD_2013_AMT.Enable = "false";    
                    form1.txtCARD_2014_AMT.Enable = "false";
                    form1.txtCARD_2013_OVER.Enable = "false";
                    form1.txtCARD_2014_OVER.Enable = "false";  
                    form1.txtCARD_2015_AMT.Enable = "false";  
                    form1.txtCARD_2015_FH_OVER.Enable = "false";  
                    form1.txtCARD_2015_SH_OVER.Enable = "false";  
                    
                    form1.txt_CARD_DUMMY1.Enable = "false";    
                    form1.txt_CARD_DUMMY2.Enable = "false";
                    form1.txt_CARD_DUMMY3.Enable = "false";
                    form1.txt_CARD_DUMMY4.Enable = "false";
                    form1.txt_CARD_DUMMY5.Enable = "false";
                    form1.txt_CARD_DUMMY6.Enable = "false";
                    form1.txt_CARD_DUMMY7.Enable = "false";
                                        
                    form1.txtCARD_2013_AMT.text =  0;    
                    form1.txtCARD_2014_AMT.text = 0;
                    form1.txtCARD_2013_OVER.text = 0;
                    form1.txtCARD_2014_OVER.text = 0;  
                    form1.txtCARD_2015_AMT.text = 0;  
                    form1.txtCARD_2015_FH_OVER.text = 0;  
                    form1.txtCARD_2015_SH_OVER.text = 0;  
                    
                    form1.txt_CARD_DUMMY1.text = 0;    
                    form1.txt_CARD_DUMMY2.text = 0;
                    form1.txt_CARD_DUMMY3.text = 0;
                    form1.txt_CARD_DUMMY4.text = 0;   
                    form1.txt_CARD_DUMMY5.text = 0;   
                    form1.txt_CARD_DUMMY6.text = 0;   
                    form1.txt_CARD_DUMMY7.text = 0;   

                    form1.txtSAJU_AMT_NTS.Enable = "false";
                    form1.txtSAJU_AMT.Enable = "false";                      
                    form1.txtSAJU_AMT_NTS.text = 0;
                    form1.txtSAJU_AMT.text = 0;                     
                    
                }else{

                    document.getElementById("cmbEDU_TAG").disabled = true;
                    document.getElementById("cmbEDU_TAG").value = "";
                    changeEduTag("");
                                      
                    form1.txtCARD_AMT_NTS.Enable = "false";
                    form1.txtCARD_AMT.Enable = "false";
                    
                    form1.txtDIR_CARD_AMT_NTS.Enable = "false";                    
                    form1.txtDIR_CARD_AMT.Enable = "false";

                    form1.txtCASH_AMT_NTS.Enable = "false";      
                    form1.txtCASH_AMT.Enable = "false"; 
                    
                    form1.txtMARKET_AMT_NTS.Enable = "false";
                    form1.txtMARKET_AMT.Enable = "false";                    
                    
                    form1.txtPUBLIC_AMT_NTS.Enable = "false";
                    form1.txtPUBLIC_AMT.Enable = "false";                    

                    form1.txtCARD_AMT_NTS.text = 0;
                    form1.txtCARD_AMT.text = 0;
                    
                    form1.txtDIR_CARD_AMT_NTS.text = 0;
                    form1.txtDIR_CARD_AMT.text = 0;

                    form1.txtCASH_AMT_NTS.text = 0;
                    form1.txtCASH_AMT.text = 0;
                    
                    form1.txtMARKET_AMT_NTS.text = 0;
                    form1.txtMARKET_AMT.text = 0;                    
                    
                    form1.txtPUBLIC_AMT_NTS.text = 0;
                    form1.txtPUBLIC_AMT.text = 0;
                    
                    form1.txtCARD_2013_AMT.Enable = "false";    
                    form1.txtCARD_2014_AMT.Enable = "false";
                    form1.txtCARD_2013_OVER.Enable = "false";
                    form1.txtCARD_2014_OVER.Enable = "false";  
                    form1.txtCARD_2015_AMT.Enable = "false";  
                    form1.txtCARD_2015_FH_OVER.Enable = "false";  
                    form1.txtCARD_2015_SH_OVER.Enable = "false";  
                                        
                    form1.txt_CARD_DUMMY1.Enable = "false";    
                    form1.txt_CARD_DUMMY2.Enable = "false";
                    form1.txt_CARD_DUMMY3.Enable = "false";
                    form1.txt_CARD_DUMMY4.Enable = "false";
                    form1.txt_CARD_DUMMY5.Enable = "false";
                    form1.txt_CARD_DUMMY6.Enable = "false";
                    form1.txt_CARD_DUMMY7.Enable = "false";
                                        
                    form1.txtCARD_2013_AMT.text =  0;    
                    form1.txtCARD_2014_AMT.text = 0;
                    form1.txtCARD_2013_OVER.text = 0;
                    form1.txtCARD_2014_OVER.text = 0;  
                    form1.txtCARD_2015_AMT.text = 0;  
                    form1.txtCARD_2015_FH_OVER.text = 0;  
                    form1.txtCARD_2015_SH_OVER.text = 0;  
                    
                    form1.txt_CARD_DUMMY1.text = 0;    
                    form1.txt_CARD_DUMMY2.text = 0;
                    form1.txt_CARD_DUMMY3.text = 0;
                    form1.txt_CARD_DUMMY4.text = 0;   
                    form1.txt_CARD_DUMMY5.text = 0;   
                    form1.txt_CARD_DUMMY6.text = 0;   
                    form1.txt_CARD_DUMMY7.text = 0;   
      

                    form1.txtSAJU_AMT_NTS.Enable = "false";
                    form1.txtSAJU_AMT.Enable = "false";                      
                    form1.txtSAJU_AMT_NTS.text = 0;
                    form1.txtSAJU_AMT.text = 0;                        
                    
                }
            }

        }


        //����ΰ��� Ŭ���ÿ���
        function fnc_chkTrbMan(){

            fnc_changeTrbManDisabled();

            var rel_cd = document.getElementById("cmbREL_CD").value;
            var cet_no = document.getElementById("txtCET_NO").value;
            var bir_yy = "";
            var age = "";
            var sex = "";

            if( cet_no != null && cet_no != "" &&
               (cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "2") ){
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "4") ){
                bir_yy = "20" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "6") ){ //�ܱ���
                bir_yy = "19" + cet_no.substring(0,2);

            }else if( cet_no != null && cet_no != "" &&
                     (cet_no.substring(7,8) == "7" || cet_no.substring(7,8) == "8") ){ //�ܱ���
                bir_yy = "20" + cet_no.substring(0,2);
            }

            if(cet_no.substring(7,8) == "1" || cet_no.substring(7,8) == "3" || cet_no.substring(7,8) == "5" || cet_no.substring(7,8) == "7"){
                sex = "M";
            }else{
                sex = "W";
            }

              age = Number(PIS_YY) - Number(bir_yy);//����


            if(document.getElementById("chkTRB_MAN").checked == true){
                //����ΰ����� ������ �⺻�����ȴ�.
                document.getElementById("chkBAS_MAN").checked = true;

                fnc_chkBasMan();

            }else{
                if(rel_cd == "1" && document.getElementById("chkBAS_MAN").checked == true){//�ҵ����� ��������

                    if(age >= 60){
                        //document.getElementById("chkBAS_MAN").checked = true;//�̹� üũ
                    }else{
                        //alert("�⺻���� ����ڰ� �ƴմϴ�.");
                        document.getElementById("chkBAS_MAN").checked = false;
                        form1.txtLIN_AMT_NTS.text = 0;
                	    form1.txtLIN_AMT.text = 0;

                	    form1.txtLIN_AMT_NTS.Enable = "false";
            			form1.txtLIN_AMT.Enable = "false";

                        return false;
                    }

                }else if(rel_cd == "2" && document.getElementById("chkBAS_MAN").checked == true){//������� ��������

                    if(age >= 60){
                        //document.getElementById("chkBAS_MAN").checked = true;//�̹� üũ
                    }else{
                        //alert("�⺻���� ����ڰ� �ƴմϴ�.");
                        document.getElementById("chkBAS_MAN").checked = false;
                        form1.txtLIN_AMT_NTS.text = 0;
                	    form1.txtLIN_AMT.text = 0;

                	    form1.txtLIN_AMT_NTS.Enable = "false";
            			form1.txtLIN_AMT.Enable = "false";
                        return false;
                    }
                }
            }

        }

        //����ΰ��� Ŭ��, ��ȸ, �ű�
        function fnc_changeTrbManDisabled(){

            if(document.getElementById("chkTRB_MAN").checked == true){
               form1.txtLIH_AMT_NTS.Enable = "true";
               form1.txtLIH_AMT.Enable = "true";
               form1.txtHED_AMT.Enable = "true";

            }else{
               form1.txtLIH_AMT_NTS.Enable = "false";
               form1.txtLIH_AMT.Enable = "false";
               form1.txtHED_AMT_NTS.Enable = "false";
               form1.txtHED_AMT.Enable = "false";

               form1.txtLIH_AMT_NTS.text = "0";
               form1.txtLIH_AMT.text = "0";
               form1.txtHED_AMT_NTS.text = "0";
               form1.txtHED_AMT.text = "0";
            }
        }



        //Ȱ��ȭ����
        function changeRelDisabled(selVal) {
        
            var cet_no = document.getElementById("txtCET_NO").value;

            document.getElementById("cmbEDU_TAG").disabled = false;
            
            fnc_Card_Setting("9");

            /****
            form1.txtCARD_AMT_NTS.Enable = "true";
            form1.txtCARD_AMT.Enable = "true";          
            
            form1.txtDIR_CARD_AMT_NTS.Enable = "true";
            form1.txtDIR_CARD_AMT.Enable = "true";
            
            form1.txtCASH_AMT_NTS.Enable = "true";
            form1.txtCASH_AMT.Enable = "true";
            
            form1.txtMARKET_AMT_NTS.Enable = "true";
            form1.txtMARKET_AMT.Enable = "false";

            form1.txtPUBLIC_AMT_NTS.Enable = "true";
            form1.txtPUBLIC_AMT.Enable = "true";
          
            form1.txtCARD_2013_AMT.Enable = "false";    
            form1.txtCARD_2014_AMT.Enable = "false";
            form1.txtCARD_2013_OVER.Enable = "false";
            form1.txtCARD_2014_OVER.Enable = "false"; 
            form1.txtCARD_2015_AMT.Enable = "false";  
            form1.txtCARD_2015_FH_OVER.Enable = "false";  
            form1.txtCARD_2015_SH_OVER.Enable = "false";  
            
            form1.txt_CARD_DUMMY1.Enable = "false";    
            form1.txt_CARD_DUMMY2.Enable = "false";
            form1.txt_CARD_DUMMY3.Enable = "false";
            form1.txt_CARD_DUMMY4.Enable = "false";  
            form1.txt_CARD_DUMMY5.Enable = "false";
            form1.txt_CARD_DUMMY6.Enable = "false";
            form1.txt_CARD_DUMMY7.Enable = "false";
  
            form1.txt_CARD_DUMMY1.text = 0;    
            form1.txt_CARD_DUMMY2.text = 0;
            form1.txt_CARD_DUMMY3.text = 0;
            form1.txt_CARD_DUMMY4.text = 0; 
            form1.txt_CARD_DUMMY5.text = 0;   
            form1.txt_CARD_DUMMY6.text = 0;   
            form1.txt_CARD_DUMMY7.text = 0;   
            ***/
            
            form1.txtSAJU_AMT_NTS.Enable = "false";
            form1.txtSAJU_AMT.Enable = "false";                                 
            
  			document.getElementById("btnPRO_PERSON").disabled = true;
  			document.getElementById("btnPRO_RENT").disabled = true;  
  			document.getElementById("btnPDF_Upload").disabled = true;  
            
            //�⺻���� ����ڰ� �ƴϸ� ����� �Է� ���Ѵ�.
            if(document.getElementById("chkBAS_MAN").checked == true){
                    form1.txtLIN_AMT_NTS.Enable = "true";
                    form1.txtLIN_AMT.Enable = "true";
            }else{
                    form1.txtLIN_AMT_NTS.Enable = "false";
                    form1.txtLIN_AMT.Enable = "false";

            }

            if(selVal == ""){
                document.getElementById("cmbREL_CD").value = "";
                document.getElementById("txtNAM_KOR").value = "";
                document.getElementById("txtCET_NO").value = "";

                document.getElementById("txtNAM_KOR").className = "input_ReadOnly";
                document.getElementById("txtNAM_KOR").readOnly = true;
                document.getElementById("txtCET_NO").className = "input_ReadOnly";
                document.getElementById("txtCET_NO").readOnly = true;

            }else{
                document.getElementById("txtNAM_KOR").className = "";
                document.getElementById("txtNAM_KOR").readOnly = false;
                document.getElementById("txtCET_NO").className = "";
                document.getElementById("txtCET_NO").readOnly = false;
            }

            if(selVal == ""){
	            document.getElementById("chkBAS_MAN").disabled = true;
	            document.getElementById("chkGOL_70").disabled = true;
	            document.getElementById("chkTRB_MAN").disabled = true;
	            document.getElementById("chkWCT_MAN").disabled = true;
	            document.getElementById("chkONE_MAN").disabled = true;
	            //�߰�
	            document.getElementById("chkINP_MAN").disabled = true;
	            document.getElementById("chkRCH_MAN").disabled = true;
	            
	            
	            //������ ��Ȱ��
                document.getElementById("cmbEDU_TAG").disabled = true;
                document.getElementById("cmbEDU_TAG").value = "";
                changeEduTag("");
                
                fnc_Card_Setting("2");
                
                /*
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                form1.txtCARD_2013_AMT.text = 0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;       
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */

                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                   
                
            }else if(selVal == "0"){//����
                document.getElementById("chkBAS_MAN").disabled = true;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                
                //�߰�
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                
                form1.radHOL_YN.Enable = true;
                form1.radINS_TAG.Enable = true;

                form1.txtLH1_AMT.Enable = "true";    // �����ϰ�� �����ڱ� Ȱ��ȭ
                //����û ���ΰ� ������ ����.2015
                //form1.txtLH2_AMT.Enable = "true";
                //form1.txtLH3_AMT.Enable = "true";
                form1.txtLH4_AMT.Enable = "true";
                form1.txtLH5_AMT.Enable = "true";
                form1.txtLH6_AMT.Enable = "true";
                form1.txtLH7_AMT.Enable = "true";
                form1.txtLH8_AMT.Enable = "true";      
                form1.txtLH9_AMT.Enable = "true";      
                form1.txtLH10_AMT.Enable = "true";      
                form1.txtLH11_AMT.Enable = "true";      
                form1.txtLH12_AMT.Enable = "true";      

                form1.txtLH1_AMT_NTS.Enable = "true";
                //����û ���ΰ� ������ ����.2015
                //form1.txtLH2_AMT_NTS.Enable = "true";
                //form1.txtLH3_AMT_NTS.Enable = "true";
                form1.txtLH4_AMT_NTS.Enable = "true";
                form1.txtLH5_AMT_NTS.Enable = "true";
                form1.txtLH6_AMT_NTS.Enable = "true";
                form1.txtLH7_AMT_NTS.Enable = "true";
                form1.txtLH8_AMT_NTS.Enable = "true";
                form1.txtLH9_AMT_NTS.Enable = "true";
                form1.txtLH10_AMT_NTS.Enable = "true";
                form1.txtLH11_AMT_NTS.Enable = "true";
                form1.txtLH12_AMT_NTS.Enable = "true";
                
                fnc_Card_Setting("1");
                
                form1.txtSAJU_AMT_NTS.Enable = "true";
                form1.txtSAJU_AMT.Enable = "true";                                     
                               
                
      			document.getElementById("btnPRO_PERSON").disabled = false;
      			document.getElementById("btnPRO_RENT").disabled = false;  
      			document.getElementById("btnPDF_Upload").disabled = false; 
                
                if( cet_no != null && cet_no != "" &&
                   (cet_no.substring(7,8) == "2" || cet_no.substring(7,8) == "4" || cet_no.substring(7,8) == "6" || cet_no.substring(7,8) == "8") ){
                    document.getElementById("chkWCT_MAN").disabled = false;//Ȱ��ȭ�Ѵ�.
                }else{
                    document.getElementById("chkWCT_MAN").checked = false;//�����ΰ�� ������ üũ ���ϰ�
                }

            }else if(selVal == "1"){//�ҵ����� ��������
            	
            	//alert("�ҵ����� ��������");
            	
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;  
                
                //�߰�
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                
                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";
                
                fnc_Card_Setting("2");
                /*
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                form1.txtCARD_2013_AMT.text = 0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;       
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */

                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                     
                
                //���������� ������ ��Ȱ��
                document.getElementById("cmbEDU_TAG").disabled = true;
                document.getElementById("cmbEDU_TAG").value = "";
                changeEduTag("");


            }else if(selVal == "2"){//������� ��������
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;     
              //�߰�
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                
                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";

                fnc_Card_Setting("2");
                /* 
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                form1.txtCARD_2013_AMT.text = 0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;       
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */
                //���������� ������ ��Ȱ��
                document.getElementById("cmbEDU_TAG").disabled = true;
                document.getElementById("cmbEDU_TAG").value = "";
                changeEduTag("");

                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;     
                
            }else if(selVal == "3"){//�����
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;    
                //�߰�
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                
                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";

                fnc_Card_Setting("2");
                 /*
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                form1.txtCARD_2013_AMT.text = 0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;       
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */
                
                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                     
                //����� �⺻���� ����
                fnc_changeBasManDisabled();

            }else if((selVal == "4") || (selVal == "5")){//������
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;    
                
                //�߰�
                //�ֹι�ȣ üũ�ؼ� �ڵ� ����
                document.getElementById("chkINP_MAN").disabled = false;
                document.getElementById("chkRCH_MAN").disabled = false;
                
                
                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";
                
                fnc_Card_Setting("2");

                /*  
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                form1.txtCARD_2013_AMT.text = 0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;       
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */
                
                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                     
            }else if(selVal == "6"){//�����ڸ�
               
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;        
                //�߰�
                document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;
                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";
 
                //�����ڸŴ� �ſ�ī�� ���� �ȵȴ�.
                form1.txtCARD_AMT_NTS.Enable = "false";
                form1.txtCARD_AMT.Enable = "false";
                form1.txtDIR_CARD_AMT_NTS.Enable = "false";
                form1.txtDIR_CARD_AMT.Enable = "false";
                form1.txtCASH_AMT_NTS.Enable = "false";
                form1.txtCASH_AMT.Enable = "false";
                form1.txtMARKET_AMT_NTS.Enable = "false";
                form1.txtMARKET_AMT.Enable = "false";      
                form1.txtPUBLIC_AMT_NTS.Enable = "false";
                form1.txtPUBLIC_AMT.Enable = "false";               
                    
                form1.txtCARD_AMT_NTS.text = 0;
                form1.txtCARD_AMT.text = 0; 
                form1.txtDIR_CARD_AMT_NTS.text = 0;                
                form1.txtDIR_CARD_AMT.text = 0;
                form1.txtCASH_AMT_NTS.text = 0;
                form1.txtCASH_AMT.text = 0;
                form1.txtMARKET_AMT_NTS.text = 0;       
                form1.txtMARKET_AMT.text = 0;
                form1.txtPUBLIC_AMT_NTS.text = 0;       
                form1.txtPUBLIC_AMT.text = 0;
                
                fnc_Card_Setting("2");
                
                /*
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                
                form1.txtCARD_2013_AMT.text =  0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;            
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */
                
                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                     
            }else if(selVal == "7"){//������
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;      
                
                //�߰�
	            document.getElementById("chkINP_MAN").disabled = true;
                document.getElementById("chkRCH_MAN").disabled = true;

                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";

                // �ſ�ī�� ���� �ȵȴ�.
               
               
                form1.txtCARD_AMT_NTS.Enable = "false";
                form1.txtCARD_AMT.Enable = "false";
                form1.txtDIR_CARD_AMT_NTS.Enable = "false";
                form1.txtDIR_CARD_AMT.Enable = "false";
                form1.txtCASH_AMT_NTS.Enable = "false";
                form1.txtCASH_AMT.Enable = "false";
                form1.txtMARKET_AMT_NTS.Enable = "false";
                form1.txtMARKET_AMT.Enable = "false";      
                form1.txtPUBLIC_AMT_NTS.Enable = "false";
                form1.txtPUBLIC_AMT.Enable = "false";               
                
                form1.txtCARD_AMT_NTS.text = 0;
                form1.txtCARD_AMT.text = 0;
                form1.txtDIR_CARD_AMT_NTS.text = 0;                
                form1.txtDIR_CARD_AMT.text = 0;
                form1.txtCASH_AMT_NTS.text = 0;
                form1.txtCASH_AMT.text = 0;
                form1.txtMARKET_AMT_NTS.text = 0;       
                form1.txtMARKET_AMT.text = 0;
                form1.txtPUBLIC_AMT_NTS.text = 0;       
                form1.txtPUBLIC_AMT.text = 0;
                
                fnc_Card_Setting("2");
                /*
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                
                form1.txtCARD_2013_AMT.text =  0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;            
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;  
                */
                
                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                     
            }else if(selVal == "8"){//��Ź�Ƶ�
                document.getElementById("chkBAS_MAN").disabled = false;
                document.getElementById("chkGOL_70").disabled = true;
                document.getElementById("chkTRB_MAN").disabled = false;
                document.getElementById("chkWCT_MAN").disabled = true;
                document.getElementById("chkONE_MAN").disabled = true;    
                
                //�߰�
	            document.getElementById("chkINP_MAN").disabled = false;
	            document.getElementById("chkRCH_MAN").disabled = false;

                form1.radHOL_YN.Enable = "false";
                form1.radINS_TAG.Enable = "false";
                

                // �ſ�ī�� ���� �ȵȴ�.
               
                form1.txtCARD_AMT_NTS.Enable = "false";
                form1.txtCARD_AMT.Enable = "false";
                form1.txtDIR_CARD_AMT_NTS.Enable = "false";
                form1.txtDIR_CARD_AMT.Enable = "false";
                form1.txtCASH_AMT_NTS.Enable = "false";
                form1.txtCASH_AMT.Enable = "false";
                form1.txtMARKET_AMT_NTS.Enable = "false";
                form1.txtMARKET_AMT.Enable = "false";      
                form1.txtPUBLIC_AMT_NTS.Enable = "false";
                form1.txtPUBLIC_AMT.Enable = "false";               
                
                form1.txtCARD_AMT_NTS.text = 0;
                form1.txtCARD_AMT.text = 0;
                form1.txtDIR_CARD_AMT_NTS.text = 0;                
                form1.txtDIR_CARD_AMT.text = 0;
                form1.txtCASH_AMT_NTS.text = 0;
                form1.txtCASH_AMT.text = 0;
                form1.txtMARKET_AMT_NTS.text = 0;       
                form1.txtMARKET_AMT.text = 0;
                form1.txtPUBLIC_AMT_NTS.text = 0;       
                form1.txtPUBLIC_AMT.text = 0;
                
                fnc_Card_Setting("2");
                /*
                form1.txtCARD_2013_AMT.Enable = "false";    
                form1.txtCARD_2014_AMT.Enable = "false";
                form1.txtCARD_2013_OVER.Enable = "false";
                form1.txtCARD_2014_OVER.Enable = "false";            
                form1.txt_CARD_DUMMY1.Enable = "false";    
                form1.txt_CARD_DUMMY2.Enable = "false";
                form1.txt_CARD_DUMMY3.Enable = "false";
                form1.txt_CARD_DUMMY4.Enable = "false";       
                
                form1.txtCARD_2013_AMT.text =  0;    
                form1.txtCARD_2014_AMT.text = 0;
                form1.txtCARD_2013_OVER.text = 0;
                form1.txtCARD_2014_OVER.text = 0;            
                form1.txt_CARD_DUMMY1.text = 0;    
                form1.txt_CARD_DUMMY2.text = 0;
                form1.txt_CARD_DUMMY3.text = 0;
                form1.txt_CARD_DUMMY4.text = 0;
                */
                
                form1.txtSAJU_AMT_NTS.Enable = "false";
                form1.txtSAJU_AMT.Enable = "false";                      
                form1.txtSAJU_AMT_NTS.text = 0;
                form1.txtSAJU_AMT.text = 0;                     
                
            }

        }
        
        
        //�ſ�ī�� ����
        function fnc_Card_Setting(param){
        	//PDF ���ε� �� ���� �Է��� ��� ����.
        	
        	
        	form1.txtCARD_AMT_NTS.Enable = "false";
            form1.txtCARD_AMT.Enable = "false";
            form1.txtDIR_CARD_AMT_NTS.Enable = "false";
            form1.txtDIR_CARD_AMT.Enable = "false";
            form1.txtCASH_AMT_NTS.Enable = "false";
            form1.txtCASH_AMT.Enable = "false";
            form1.txtMARKET_AMT_NTS.Enable = "false";
            form1.txtMARKET_AMT.Enable = "false";      
            form1.txtPUBLIC_AMT_NTS.Enable = "false";
            form1.txtPUBLIC_AMT.Enable = "false";               
                
        	
        	 form1.txtCARD_2013_AMT.Enable = "false";    
             form1.txtCARD_2014_AMT.Enable = "false";
             form1.txtCARD_2013_OVER.Enable = "false";
             form1.txtCARD_2014_OVER.Enable = "false";  
             form1.txtCARD_2015_AMT.Enable = "false";  
             form1.txtCARD_2015_FH_OVER.Enable = "false";  
             form1.txtCARD_2015_SH_OVER.Enable = "false";  
             
             form1.txt_CARD_DUMMY1.Enable = "false";    
             form1.txt_CARD_DUMMY2.Enable = "false";
             form1.txt_CARD_DUMMY3.Enable = "false";
             form1.txt_CARD_DUMMY4.Enable = "false";
             form1.txt_CARD_DUMMY5.Enable = "false";
             form1.txt_CARD_DUMMY6.Enable = "false";
             form1.txt_CARD_DUMMY7.Enable = "false";
             
             form1.txt_CARD_DUMMY1.text = 0;    
             form1.txt_CARD_DUMMY2.text = 0;
             form1.txt_CARD_DUMMY3.text = 0;
             form1.txt_CARD_DUMMY4.text = 0;   
             form1.txt_CARD_DUMMY5.text = 0;   
             form1.txt_CARD_DUMMY6.text = 0;   
             form1.txt_CARD_DUMMY7.text = 0;   
                       	
        	return ;
        	
        	
            if(param=="1"){//����
            	
            	
            	form1.txtCARD_2013_AMT.Enable = "true";    
                form1.txtCARD_2014_AMT.Enable = "true";
                form1.txtCARD_2013_OVER.Enable = "true";
                form1.txtCARD_2014_OVER.Enable = "true";    
                form1.txtCARD_2015_AMT.Enable = "true";  
                form1.txtCARD_2015_FH_OVER.Enable = "true";  
                form1.txtCARD_2015_SH_OVER.Enable = "true";
                
            }else{ //���ο�

            	 form1.txtCARD_2013_AMT.Enable = "false";    
                 form1.txtCARD_2014_AMT.Enable = "false";
                 form1.txtCARD_2013_OVER.Enable = "false";
                 form1.txtCARD_2014_OVER.Enable = "false";  
                 form1.txtCARD_2015_AMT.Enable = "false";  
                 form1.txtCARD_2015_FH_OVER.Enable = "false";  
                 form1.txtCARD_2015_SH_OVER.Enable = "false";  
              
                 form1.txtCARD_2013_AMT.text =  0;    
                 form1.txtCARD_2014_AMT.text = 0;
                 form1.txtCARD_2013_OVER.text = 0;
                 form1.txtCARD_2014_OVER.text = 0;  
                 form1.txtCARD_2015_AMT.text = 0;  
                 form1.txtCARD_2015_FH_OVER.text = 0;  
                 form1.txtCARD_2015_SH_OVER.text = 0;  
                
            }
            
            
            
            
            form1.txt_CARD_DUMMY1.Enable = "false";    
            form1.txt_CARD_DUMMY2.Enable = "false";
            form1.txt_CARD_DUMMY3.Enable = "false";
            form1.txt_CARD_DUMMY4.Enable = "false";
            form1.txt_CARD_DUMMY5.Enable = "false";
            form1.txt_CARD_DUMMY6.Enable = "false";
            form1.txt_CARD_DUMMY7.Enable = "false";
            
            form1.txt_CARD_DUMMY1.text = 0;    
            form1.txt_CARD_DUMMY2.text = 0;
            form1.txt_CARD_DUMMY3.text = 0;
            form1.txt_CARD_DUMMY4.text = 0;   
            form1.txt_CARD_DUMMY5.text = 0;   
            form1.txt_CARD_DUMMY6.text = 0;   
            form1.txt_CARD_DUMMY7.text = 0;   
        }
        
      /**************************************************  
      //�Լ����� : �ſ�ī�� PDF ���� ���ε�
      1. ���� �����Ͱ� �����ϸ� ���� �� INSERT
      2. PDF ���ε�� ���� �Ұ� ( ��, ���� �� �Է� ���� )
      3. ���������ڵ�� PDF ���� üũ...(�ֹι�ȣ�� ������ Ȯ��)
      ***************************************************/
      function fnc_Pdf_Upload(){
    	  
    	  var rel_cd = document.getElementById("cmbREL_CD").value;
    	  
    	  if (rel_cd!="0"){
    		  alert("�ξ� ������ ���� ���� ��  PDF���� �ϰ� ���ε� �����մϴ�.");
    		  return false;
    	  }
    	  
    	  var href_page = "yaca099_15.jsp"
			   		    + "?PIS_YY="+PIS_YY
					    + "&ENO_NO="+ENO_NO
					    + "&ENO_NM="+ENO_NM
    		            + "&CET_NO="+CET_NO;
		                            
	      window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:725px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
	    
	      fnc_SearchList();
		
      }

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                      |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_FAMILY)                |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                    |
    +------------------------------------------------------>
    <Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_FAMILY1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="/Ehr/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FA"/>
       <jsp:param name="CODE_GUBUN"    value="FA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_FAMILY)                |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_FAMILY)                |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_FAMILY1" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�

            //checkbox ó��
            if(dsT_AC_FAMILY.NameValue(1, "BAS_MAN") == "O") document.getElementById("chkBAS_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "WCT_MAN") == "O") document.getElementById("chkWCT_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "TRB_MAN") == "O") document.getElementById("chkTRB_MAN").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "GOL_70") == "O") document.getElementById("chkGOL_70").checked = true;
            if(dsT_AC_FAMILY.NameValue(1, "ONE_MAN") == "O") document.getElementById("chkONE_MAN").checked = true;
            
            if(dsT_AC_FAMILY.NameValue(1, "INP_MAN") == "O") document.getElementById("chkINP_MAN").checked = true;            
            if(dsT_AC_FAMILY.NameValue(1, "RCH_MAN") == "O") document.getElementById("chkRCH_MAN").checked = true;
            
            changeRelDisabled(dsT_AC_FAMILY.NameValue(1, "REL_CD"));

            //�з� ���� �ڵ�
            changeEduTag(dsT_AC_FAMILY.NameValue(1, "EDU_TAG"));

            //����ΰ���
            //�߸������ ������ Ȯ���Ҽ��ְ� 0���� ó�� ���ϱ� ���� �Լ����� ���� ����
            //fnc_changeTrbManDisabled();
            if(document.getElementById("chkTRB_MAN").checked == true){
               form1.txtLIH_AMT_NTS.Enable = "true";
               form1.txtLIH_AMT.Enable = "true";
               form1.txtHED_AMT.Enable = "true";

            }else{
               form1.txtLIH_AMT_NTS.Enable = "false";
               form1.txtLIH_AMT.Enable = "false";
               form1.txtHED_AMT_NTS.Enable = "false";
               form1.txtHED_AMT.Enable = "false";

            }

            //�⺻ ������ �������ϰ� ����
            fnc_ChangeStateElement(false, "cmbREL_CD");
            fnc_ChangeStateElement(false, "txtNAM_KOR");
            fnc_ChangeStateElement(false, "txtCET_NO");
            
            fnc_Card_Setting("9");
        }
    </Script>

	<script language=JavaScript for=txtCARD_AMT_NTS event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
	</script>

	<script language=JavaScript for=txtDIR_CARD_AMT_NTS event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtCASH_AMT_NTS event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtCARD_AMT event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtDIR_CARD_AMT event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtCASH_AMT event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text)  +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtMARKET_AMT_NTS event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text)  +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtPUBLIC_AMT_NTS event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>

	<script language=JavaScript for=txtPUBLIC_AMT event=OnKillFocus()>
    //2014�⵵ �ſ�ī��� �ݾ� �ڵ� ���
    document.getElementById("txtCARD_2014_AMT").text = parseInt(document.getElementById("txtCARD_AMT_NTS").text) + parseInt(document.getElementById("txtDIR_CARD_AMT_NTS").text) + parseInt(document.getElementById("txtCASH_AMT_NTS").text)
    																		+parseInt(document.getElementById("txtCARD_AMT").text) + parseInt(document.getElementById("txtDIR_CARD_AMT").text) + parseInt(document.getElementById("txtCASH_AMT").text)
    																		+parseInt(document.getElementById("txtMARKET_AMT_NTS").text) +parseInt(document.getElementById("txtPUBLIC_AMT_NTS").text) + parseInt(document.getElementById("txtPUBLIC_AMT").text);
    </script>





	<script language=JavaScript for=txtLIN_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLIN_AMT_NTS").text == 0){
    	document.getElementById("txtLIN_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLIN_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLIN_AMT").text == 0){
    	document.getElementById("txtLIN_AMT").text = '';
    }
	</script>
	
	<script language=JavaScript for=txtLIH_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLIH_AMT_NTS").text == 0){
    	document.getElementById("txtLIH_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLIH_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLIH_AMT").text == 0){
    	document.getElementById("txtLIH_AMT").text = '';
    }
	</script>	

	<script language=JavaScript for=txtEDU_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtEDU_AMT_NTS").text == 0){
    	document.getElementById("txtEDU_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtEDU_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtEDU_AMT").text == 0){
    	document.getElementById("txtEDU_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtHED_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtHED_AMT_NTS").text == 0){
    	document.getElementById("txtHED_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtHED_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtHED_AMT").text == 0){
    	document.getElementById("txtHED_AMT").text = '';
    }
	</script>
	
	<script language=JavaScript for=txtCARD_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCARD_AMT_NTS").text == 0){
    	document.getElementById("txtCARD_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtCARD_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCARD_AMT").text == 0){
    	document.getElementById("txtCARD_AMT").text = '';
    }
	</script>	

	<script language=JavaScript for=txtDIR_CARD_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtDIR_CARD_AMT_NTS").text == 0){
    	document.getElementById("txtDIR_CARD_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtDIR_CARD_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtDIR_CARD_AMT").text == 0){
    	document.getElementById("txtDIR_CARD_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtCASH_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCASH_AMT_NTS").text == 0){
    	document.getElementById("txtCASH_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtCASH_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCASH_AMT").text == 0){
    	document.getElementById("txtCASH_AMT").text = '';
    }
	</script>
	
	<script language=JavaScript for=txtMARKET_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtMARKET_AMT_NTS").text == 0){
    	document.getElementById("txtMARKET_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtPUBLIC_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtPUBLIC_AMT_NTS").text == 0){
    	document.getElementById("txtPUBLIC_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtPUBLIC_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtPUBLIC_AMT").text == 0){
    	document.getElementById("txtPUBLIC_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtCARD_2013_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCARD_2013_AMT").text == 0){
    	document.getElementById("txtCARD_2013_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtCARD_2014_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCARD_2014_AMT").text == 0){
    	document.getElementById("txtCARD_2014_AMT").text = '';
    }
	</script>
	
	<script language=JavaScript for=txtCARD_2013_OVER event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCARD_2013_OVER").text == 0){
    	document.getElementById("txtCARD_2013_OVER").text = '';
    }
	</script>

	<script language=JavaScript for=txtCARD_2014_OVER event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtCARD_2014_OVER").text == 0){
    	document.getElementById("txtCARD_2014_OVER").text = '';
    }
	</script>	

	<script language=JavaScript for=txtLH1_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH1_AMT_NTS").text == 0){
    	document.getElementById("txtLH1_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH1_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH1_AMT").text == 0){
    	document.getElementById("txtLH1_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH2_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH2_AMT_NTS").text == 0){
    	document.getElementById("txtLH2_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH2_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH2_AMT").text == 0){
    	document.getElementById("txtLH2_AMT").text = '';
    }
	</script>
	
	<script language=JavaScript for=txtLH3_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH3_AMT_NTS").text == 0){
    	document.getElementById("txtLH3_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH3_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH3_AMT").text == 0){
    	document.getElementById("txtLH3_AMT").text = '';
    }
	</script>	

	<script language=JavaScript for=txtLH4_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH4_AMT_NTS").text == 0){
    	document.getElementById("txtLH4_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH4_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH4_AMT").text == 0){
    	document.getElementById("txtLH4_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH5_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH5_AMT_NTS").text == 0){
    	document.getElementById("txtLH5_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH5_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH5_AMT").text == 0){
    	document.getElementById("txtLH5_AMT").text = '';
    }
	</script>
	
	<script language=JavaScript for=txtLH6_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH6_AMT_NTS").text == 0){
    	document.getElementById("txtLH6_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH6_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH6_AMT").text == 0){
    	document.getElementById("txtLH6_AMT").text = '';
    }
	</script>	

	<script language=JavaScript for=txtLH7_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH7_AMT_NTS").text == 0){
    	document.getElementById("txtLH7_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH7_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH7_AMT").text == 0){
    	document.getElementById("txtLH7_AMT").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH8_AMT_NTS event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH8_AMT_NTS").text == 0){
    	document.getElementById("txtLH8_AMT_NTS").text = '';
    }
	</script>

	<script language=JavaScript for=txtLH8_AMT event=onSetFocus()>
    //ȭ�� ������� �ȿ� �ִ� ���� 0 �̸� ��ĭ���� �ǵ���
    if(document.getElementById("txtLH8_AMT").text == 0){
    	document.getElementById("txtLH8_AMT").text = '';
    }
	</script>
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnSuccess()">
        alert("���������� ����Ǿ����ϴ�!");
        window.close();
        //DataSet�� �Է»��·� ����, T_AC_RETACC �� ���� �ȵǴ� ���̽��� �־� �ٽ� �� �� ȣ��
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
        window.close();
    </script>

    <script for=trT_AC_FAMILY1 event="OnSuccess()">

        params = "&S_MODE=SHR_14"
              + "&PIS_YY="+PIS_YY
              + "&ENO_NO="+ENO_NO;

       	dsT_AC_FAMILY1.dataid = dataClassName+params;
       	dsT_AC_FAMILY1.reset();

		var med_amt = 0;

		if (dsT_AC_FAMILY1.CountRow > 0)    {
			for(var i=1; i<=dsT_AC_FAMILY1.CountRow; i++) {
				med_amt += dsT_AC_FAMILY1.NameValue(i,"MED_AMT");
			}
        }

        window.close();

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY1 event="OnFail()">
        cfErrorMsg(this);
        window.close();
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">
<br>
    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="700" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�ξ簡�����</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">�ξ簡�����</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="690" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="blueBold" align="center">�г���û����</td>
            <td class="padding2423" >
				<object id=radINS_TAG classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:20; width:150">
					<param name=AutoMargin		value="false">
					<param name=DataID      	value="dsT_AC_FAMILY">
					<param name=CodeColumn  	value="INS_TAG">
					<param name=Cols			value="2">
					<param name=Format			value="Y^��û,N^�̽�û">
				</object>																	
		    </td>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- ���� �Է� ���̺� ���� -->
    <table width="690" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="100"></col>
                        <col width="70"></col>
                        <col width="110"></col>
                        <col width="80"></col>                        
                        <col width="80"></col>
                        <col width="80"></col>
                        <col width="100"></col>
                    </colgroup>
                    <tr>
                        <td class="blueBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423" colspan="4">
                            <select id="cmbREL_CD" name="cmbREL_CD" onchange="changeRelTag(this.value)">
                                <option value=""></option>
                            </select>
                        </td>
                        
                        <td class="padding2423" align="left"  colspan="3" >&nbsp;�����ֿ���&nbsp;&nbsp;
							<object id=radHOL_YN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:10; width:110">
								<param name=AutoMargin		value="false">
								<param name=DataID      	value="dsT_AC_FAMILY">
								<param name=CodeColumn  	value="HOL_YN">
								<param name=Cols			value="2">
								<param name=Format			value="Y^Yes   ,N^No">
							</object>																	
						</td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <input id="txtNAM_KOR" maxlength="5" style="width:100%">
                        </td>
                        <td class="blueBold" align="center">�ֹι�ȣ</td>
                        <td class="padding2423">
                            <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onchange="changeCetTag()">
                        </td>
                        <td class="blueBold" align="center">��ֿ���</td>
                        <td class="padding2423" colspan ="3">
                            <select id="cmbINV_MAN" name="cmbINV_MAN" onchange="changeTrbTag(this.value)">
                                <option value="0">�������</option>
	                            <option value="1">����κ������� ���� �����</option>
	                            <option value="2">���������ڵ� ����� ������ ���� �����</option>
	                            <option value="3">�׽� ġ�Ḧ ���ϴ� ����ȯ��</option>                                
                            </select>
                        </td>                        
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" height="20px">�����׸�</td>
                        <td colspan="7" height="20px">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			                    <colgroup>
			                        <col width="70"></col>
			                        <col width="100"></col>
			                        <col width="80"></col>	
			                        <col width="80"></col>
			                        <col width="80"></col>
			                        <col width="80"></col>                     
			                        <col width=""></col>
			                    </colgroup>
                                <tr>
			                        <td class="padding2423" valign="top">
			                            <input type="checkbox" name="chkBAS_MAN" id="chkBAS_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkBasMan()">�⺻����
			                        </td>
			                        
			                        <td class="padding2423" valign="top" >
										<input type="checkbox" name="chkGOL_70" id="chkGOL_70" style="border:0" align="absmiddle" value="">��ο�����		
									</td>
									
									<td class="padding2423" valign="top" >
										<input type="checkbox" name="chkTRB_MAN" id="chkTRB_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkTrbMan();">����ΰ���					
									</td>
			                        
			                        <td class="padding2423" valign="top" >
										<input type="checkbox" name="chkWCT_MAN" id="chkWCT_MAN" style="border:0" align="absmiddle" value="" onclick="fnc_chkWctMan();">�γ��ڰ���			
									</td>
									
									<td class="padding2423" valign="top" >
										<input type="checkbox" name="chkONE_MAN" id="chkONE_MAN" style="border:0" value="">�Ѻθ����		
									</td>
									
									<td class="padding2423"  valign="top">
			                            <input type="checkbox" name="chkINP_MAN" id="chkINP_MAN" style="border:0" value="">���,�Ծ�
			                        </td>	
			                        
			                        <td class="padding2423"  valign="top">
			                            <input type="checkbox" name="chkRCH_MAN" id="chkRCH_MAN" style="border:0" value="">6������
			                        </td>	
									 
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br>
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="130"></col>
                        <col width="95"></col>
                        <col width="85"></col>
                        <col width="100"></col>                        
                        <col width="200"></col>
                        <col width="100"></col>                        
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="blueBold" align="center" colspan="5">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="blueBold" align="center">����û �ڷ�</td>
                        <td class="blueBold" align="center">�׹��� �ڷ�</td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" rowspan="2">
                        �����</td>
                        <td class="blueBold" align="center" colspan="4">���强�����</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIN_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="4">��������뺸���</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIH_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLIH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>

                    <tr>
                         <td class="blueBold" align="center" rowspan="2">
                            ������
                        </td>
                        <td class="blueBold" align="center" colspan="4">
                            <table>
                                <tr>
                                    <td class="blueBold" align="center">������</td>
                                    <td><select id="cmbEDU_TAG" name="cmbEDU_TAG" style="width:100px" onchange="changeEduTag(this.value)">
	                                        <option value=""></option>
	                                        <option value="1">������</option>
	                                        <option value="2">���߰�</option>
	                                        <option value="3">���б�</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtEDU_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="4">�����Ư��������</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtHED_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtHED_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="center" rowspan="12">
                            �ſ�ī�� ����<br>
                             
                    <br> <button id="btnPDF_Upload"  style="cursor:hand;width:90pt;height:15pt;" onclick="fnc_Pdf_Upload();"><font color="red"><b>PDF���� ���ε�</b></font></button>
                            
                        </td>
                        <td class="blueBold" align="center" colspan="4">�ſ�ī��<font color="blue"><b>(���߱���,������� ����)</b></font></td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="4">����/����ī��<font color="blue"><b>(���߱���,������� ����)</b></font></td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtDIR_CARD_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtDIR_CARD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" colspan="4">���ݿ�����<font color="blue"><b>(���߱���,������� ����)</b></font></td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCASH_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCASH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="4">��������� �Ѿ�</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtMARKET_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtMARKET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                                        
                                      
                    <tr>
                        <td class="blueBold" align="center" colspan="4">���߱����̿� �Ѿ�</td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtPUBLIC_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtPUBLIC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>        

                    <tr>
                        <td class="blueBold" align="center" rowspan="7">���� </td>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�ſ�ī��� ����(2013��)&nbsp;
                            <button id="btnPRO_STS_1"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert1();"><font color="blue"><b>����</b></font></button>                         
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2013_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                  

                    <tr>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�ſ�ī��� ����(2014��)&nbsp;
                        	<button id="btnPRO_STS_2"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert2();"><font color="blue"><b>����</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2014_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                   

                    <tr>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�߰������� ����(2013��)&nbsp;
                        	<button id="btnPRO_STS_3"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert3();"><font color="blue"><b>����</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2013_OVER" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                      
                                                      
                    <tr>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�߰������� ����(2015�� ��ݱ�)&nbsp;
                        	<button id="btnPRO_STS_4"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert4();"><font color="blue"><b>����</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2015_FH_OVER" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY4" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>  
                    <tr>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�ſ�ī��� ����(2015��)&nbsp;
                        	<button id="btnPRO_STS_4"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert5();"><font color="blue"><b>����</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2015_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY5" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                           
                    
                    <tr>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�߰������� ����(2014��)&nbsp;
                        	<button id="btnPRO_STS_4"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert6();"><font color="blue"><b>����</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2014_OVER" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY6" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                           
                    
                    <tr>
                        <td class="blueBold" align="left" colspan="3">&nbsp;�߰������� ����(2015�� �Ϲݱ�)&nbsp;
                        	<button id="btnPRO_STS_4"  style="cursor:hand;width:30pt;height:15pt;" onclick="fnc_Alert7();"><font color="blue"><b>����</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtCARD_2015_SH_OVER" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txt_CARD_DUMMY7" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                                                    
                  
                     <tr>
                        <td class="blueBold" align="center" >
                            �츮����
                        </td>
                        <td class="blueBold" align="center" colspan="4">�츮�������� �⿬��</td>                      
                        <td class="padding2423" align="center" style="padding-right:5px"  >
                            <comment id="__NSID__">
                            <object id="txtSAJU_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                      
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtSAJU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>                  
                  
                  
                     <tr>
                        <td class="blueBold" align="center" rowspan="12">
                            �����ڱ�
                        </td>
                        <td class="blueBold" align="center" rowspan="2">��������<br>���Ա�</td>
                        <td class="blueBold" align="center" colspan="3">������</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px"  >
                            <comment id="__NSID__">
                            <object id="txtLH1_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                      
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH1_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>

                        <td class="blueBold" align="center" colspan="3">���ΰ�&nbsp;&nbsp;
                        	<button id="btnPRO_PERSON"  style="cursor:hand;width:70pt;height:15pt;" onclick="fnc_RegPerson();"><font color="red"><b>�Է� Click!</b></font></button>                        
                        </td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">  
                            <comment id="__NSID__">
                            <object id="txtLH2_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td> 
                    </tr>
                    
					<tr>
                        <td class="blueBold" align="center" colspan="4" >������&nbsp;&nbsp;
                             <button id="btnPRO_RENT"  style="cursor:hand;width:70pt;height:15pt;" onclick="fnc_RegRent();"><font color="red"><b>�Է�  Click!</b></font></button>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">   
                            <comment id="__NSID__">
                            <object id="txtLH3_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH3_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>    
                        </td>
                    </tr>
                                        
                    <tr>
                        <td class="blueBold" align="center" rowspan="9">�������<br>�������Ա�</td>
                		<td class="blueBold" align="center" rowspan="3">2011��<br>�������Ժ�</td>                          
                        <td class="blueBold" align="center" colspan="2">15�� �̸�</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH4_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH4_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">15 ~ 29��</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH5_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH5_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">30�� �̻�</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH6_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH6_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                		<td class="blueBold" align="center" rowspan="2">2012��<br>�������Ժ�</td>                          
                        <td class="blueBold" align="center" colspan="2">�����ݸ�/���ġ</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH7_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH7_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">��Ÿ����</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH8_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH8_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="center" rowspan="4">2015<strong></strong>��<br>�������Ժ�</td>
                        <td class="blueBold" align="center" rowspan="3">15���̻�</td>
                        <td class="blueBold" align="center" >�����ݸ� AND ���ġ</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH9_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH9_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" >�����ݸ� OR ���ġ</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH10_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH10_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" >�Ϲ����� ����</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH11_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH11_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    
                    <tr>
          
                        <td class="blueBold" align="center" >10 ~ 14��</td>
                        <td class="blueBold" align="center" >�����ݸ� OR ���ġ</td>                        
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH12_AMT_NTS" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="padding2423" align="center" style="padding-right:5px">
                            <comment id="__NSID__">
                            <object id="txtLH12_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
            
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� �Է� ���̺� �� -->

    </form>
    <!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_AC_FAMILY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_FAMILY">
    <Param Name="BindInfo", Value='
        <C>Col=REL_CD               Ctrl=cmbREL_CD              Param=value     </C>
        <C>Col=NAM_KOR              Ctrl=txtNAM_KOR             Param=value     </C>
        <C>Col=CET_NO               Ctrl=txtCET_NO              Param=value     </C>
        <C>Col=INV_MAN              Ctrl=cmbINV_MAN             Param=value     </C>        
        <C>Col=EDU_TAG              Ctrl=cmbEDU_TAG             Param=value     </C>
        <C>Col=LIN_AMT_NTS          Ctrl=txtLIN_AMT_NTS         Param=text      </C>
        <C>Col=LIH_AMT_NTS          Ctrl=txtLIH_AMT_NTS         Param=text      </C>
        <C>Col=MED_AMT_NTS          Ctrl=txtMED_AMT_NTS         Param=text      </C>
        <C>Col=LEN_AMT_NTS          Ctrl=txtLEN_AMT_NTS         Param=text      </C>
        <C>Col=EDU_AMT_NTS          Ctrl=txtEDU_AMT_NTS         Param=text      </C>
        <C>Col=HED_AMT_NTS          Ctrl=txtHED_AMT_NTS         Param=text      </C>
        <C>Col=CARD_AMT_NTS         Ctrl=txtCARD_AMT_NTS        Param=text      </C>
        <C>Col=DIR_CARD_AMT_NTS     Ctrl=txtDIR_CARD_AMT_NTS    Param=text      </C>
        <C>Col=CASH_AMT_NTS         Ctrl=txtCASH_AMT_NTS        Param=text      </C>
        <C>Col=MARKET_AMT_NTS       Ctrl=txtMARKET_AMT_NTS      Param=text      </C>    
        <C>Col=PUBLIC_AMT_NTS       Ctrl=txtPUBLIC_AMT_NTS      Param=text      </C>
        <C>Col=LIN_AMT              Ctrl=txtLIN_AMT             Param=text      </C>
        <C>Col=LIH_AMT              Ctrl=txtLIH_AMT             Param=text      </C>
        <C>Col=MED_AMT              Ctrl=txtMED_AMT             Param=text      </C>
        <C>Col=LEN_AMT              Ctrl=txtLEN_AMT             Param=text      </C>
        <C>Col=EDU_AMT              Ctrl=txtEDU_AMT             Param=text      </C>
        <C>Col=HED_AMT             	Ctrl=txtHED_AMT             Param=text      </C>
        <C>Col=CARD_AMT            	Ctrl=txtCARD_AMT            Param=text      </C>
        <C>Col=DIR_CARD_AMT         Ctrl=txtDIR_CARD_AMT        Param=text      </C>
        <C>Col=CASH_AMT             Ctrl=txtCASH_AMT            Param=text      </C>
        <C>Col=MARKET_AMT           Ctrl=txtMARKET_AMT          Param=text      </C>
        <C>Col=PUBLIC_AMT           Ctrl=txtPUBLIC_AMT          Param=text      </C>

        <C>Col=CARD_2013_AMT        Ctrl=txtCARD_2013_AMT       Param=text      </C>
        <C>Col=CARD_2014_AMT        Ctrl=txtCARD_2014_AMT       Param=text      </C>
        <C>Col=CARD_2013_OVER       Ctrl=txtCARD_2013_OVER      Param=text      </C>
        <C>Col=CARD_2014_OVER       Ctrl=txtCARD_2014_OVER      Param=text      </C>
        
        <C>Col=CARD_2015_AMT        Ctrl=txtCARD_2015_AMT       Param=text      </C>
        <C>Col=CARD_2015_FH_OVER    Ctrl=txtCARD_2015_FH_OVER   Param=text      </C>
        <C>Col=CARD_2015_SH_OVER    Ctrl=txtCARD_2015_SH_OVER   Param=text      </C>

        <C>Col=LH1_AMT              Ctrl=txtLH1_AMT             Param=text      </C>          
        <C>Col=LH2_AMT            	Ctrl=txtLH2_AMT           	Param=text      </C>
        <C>Col=LH3_AMT              Ctrl=txtLH3_AMT             Param=text      </C>
        <C>Col=LH4_AMT              Ctrl=txtLH4_AMT             Param=text      </C>
        <C>Col=LH5_AMT              Ctrl=txtLH5_AMT             Param=text      </C>
        <C>Col=LH6_AMT              Ctrl=txtLH6_AMT             Param=text      </C>
        <C>Col=LH7_AMT              Ctrl=txtLH7_AMT             Param=text      </C>
        <C>Col=LH8_AMT              Ctrl=txtLH8_AMT             Param=text      </C>  
        <C>Col=LH9_AMT              Ctrl=txtLH9_AMT             Param=text      </C>  
        <C>Col=LH10_AMT             Ctrl=txtLH10_AMT            Param=text      </C>  
        <C>Col=LH11_AMT             Ctrl=txtLH11_AMT            Param=text      </C>  
        <C>Col=LH12_AMT             Ctrl=txtLH12_AMT            Param=text      </C>                

        <C>Col=LH1_AMT_NTS          Ctrl=txtLH1_AMT_NTS         Param=text      </C>        
        <C>Col=LH2_AMT_NTS        	Ctrl=txtLH2_AMT_NTS       	Param=text      </C>
        <C>Col=LH3_AMT_NTS          Ctrl=txtLH3_AMT_NTS         Param=text      </C>
        <C>Col=LH4_AMT_NTS          Ctrl=txtLH4_AMT_NTS         Param=text      </C>
        <C>Col=LH5_AMT_NTS          Ctrl=txtLH5_AMT_NTS         Param=text      </C>
        <C>Col=LH6_AMT_NTS          Ctrl=txtLH6_AMT_NTS         Param=text      </C>
        <C>Col=LH7_AMT_NTS          Ctrl=txtLH7_AMT_NTS         Param=text      </C>
        <C>Col=LH8_AMT_NTS          Ctrl=txtLH8_AMT_NTS         Param=text      </C>
        <C>Col=LH9_AMT_NTS          Ctrl=txtLH9_AMT_NTS         Param=text      </C>
        <C>Col=LH10_AMT_NTS         Ctrl=txtLH10_AMT_NTS        Param=text      </C>
        <C>Col=LH11_AMT_NTS         Ctrl=txtLH11_AMT_NTS        Param=text      </C>
        <C>Col=LH12_AMT_NTS         Ctrl=txtLH12_AMT_NTS        Param=text      </C>
        
        <C>Col=SAJU_AMT_NTS	        Ctrl=txtSAJU_AMT_NTS        Param=text      </C>        
        <C>Col=SAJU_AMT	          	Ctrl=txtSAJU_AMT         	Param=text      </C>        
        <C>Col=HOL_YN           	Ctrl=radHOL_YN              Param=CodeValue </C>
        <C>Col=INS_TAG           	Ctrl=radINS_TAG             Param=CodeValue </C>
        
    '>
</object>