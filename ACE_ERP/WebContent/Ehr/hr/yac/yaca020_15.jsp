<!--
*****************************************************************************
* @source      : yaca020_2015.jsp                                              *
* @description : �ͼ�2015�⵵ �������� �����Ű� �ۼ� PAGE                       *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*----------------------------------------------------------------------------
* 2014/12/17            �̵���             ������                                             *
* 2013/10/27            �̵���             ���� - Ehr���� Erp�� �Ѿ� �±� Session�̶� ��Ÿ ��� Ȯ�� �ʿ�              *
*****************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<% String ss_userid   = (String)session.getAttribute("vusrid"); %>
<% String ss_usernm = (String)session.getAttribute("vusrnm");%>

<% String ENO_NO     = request.getParameter("ENO_NO"); %>
<% String ENO_NM     = request.getParameter("ENO_NM"); %>
<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

<title>�������� �����Ű� �Է�(2015�⵵)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="../../common/common.js"></script>
<script language=javascript src="../../common/result.js"></script>
<script language=javascript src="../../common/input.js"></script>
<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

<script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
                    
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;

        var dataClassName_01 = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca021.cmd.YACA021CMD";
        var params_01 = null;

		var submit_chk = "N";
		
        var dsTemp = window.dialogArguments;		
		var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";	
		
		
		//^^���Ƿ� ����
		//ENO_NO ="2040080";
		
		/******************************************************************************
		Description : ������ �ε�
		******************************************************************************/

		function fnOnLoad(tree_idx){
	
		    fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		}

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ         *   ok
          ********************************************/
        function fnc_SearchList() {

            //�������� ��ȸ
            //^^params = "&S_MODE=SHR_142"
            params = "&S_MODE=SHR_15"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;

            trT_AC_RETACC.KeyValue = "tr"
                                   + "(O:dsT_AC_RETACC=dsT_AC_RETACC)";
            trT_AC_RETACC.action = dataClassName+params;

            trT_AC_RETACC.post();

            if(dsT_AC_RETACC.CountRow >= 1)
            {

    			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
    				document.getElementById("chkCLS_TAG").checked = true;
    			}else{
    				document.getElementById("chkCLS_TAG").checked = false;
    			}

	            fnc_SearchList_01(); //�ξ簡�� ��Ȳ��ȸ
	       
	            document.getElementById("txtSALT_AMT").value    = dsT_AC_RETACC.NameValue(1, "SALT_AMT");	 //�������޿�
	            document.getElementById("txtFREE_INCOME").value = dsT_AC_RETACC.NameValue(1, "FREE_INCOME"); //�����
	            document.getElementById("txtTAX_INCOME").value  = dsT_AC_RETACC.NameValue(1, "TAX_INCOME");  //�ѱٷμҵ�
	            document.getElementById("txtINCM_TAX").value    = dsT_AC_RETACC.NameValue(1, "INCM_TAX");    //�ⳳ�� �ҵ漼
	            document.getElementById("txtCITI_TAX").value    = dsT_AC_RETACC.NameValue(1, "CITI_TAX");    //�ⳳ�� �ֹμ�           
	
	            var txtFUN_CNTNM = '';
	            
				if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y"){			
		            
					document.getElementById("txtFUN_CNTNM").value = '����Ϸ�';
					
				}else{
					
					document.getElementById("txtFUN_CNTNM").value = '������';
					
				}
	
	            submit_chk  = dsT_AC_RETACC.NameValue(1, "FUN_CNT");		//���⿩��           
	            
				if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == " N"){			
		            
					fnc_disableInput();
					
				}               

            }

        }

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)    								*
         ********************************************/
  		function fnc_disableInput(param){

			alert("���������� �����Դϴ�.\n������ �Ұ����մϴ�.");

			submit_chk = "Y";	

        }

        /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)       								*
         ********************************************/
  		function fnc_enableInput(){

  		}

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
   
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }
        
        
        
        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_UpdateAcc() {

			var pis_yy  = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_MEDICAL2.UseChangeInfo = false;

			dsT_AC_MEDICAL2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=ACC_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_MEDICAL2.reset();        	
        	

			dsT_AC_DONATION2.UseChangeInfo = false;

			dsT_AC_DONATION2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=ACC_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_DONATION2.reset();        	
			
			
        }        
        

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        	// JYS 20160114 �ǹ� ��� ����
			//fnc_UpdateAcc();        	
        	
            //��� ������ �۾��� ������.
    		ds_print.ClearAll();

            var row=0;

			var pis_yy  = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;
            
    		ln_Rpt_SetDataHeader();//����Ÿ ����� 

            ds_print.addrow();

    		//ds_print2.��¸��	
			//ds_print2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR2_PRT_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR2_PRT_15&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print2.reset();    		
    		
    		//ds_print3.��������			
			//ds_print3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR3_PRT_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR3_PRT_15&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print3.reset(); 			
			
    		//ds_print4. 2.3PAGE			
			//ds_print4.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR4_PRT_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print4.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR4_PRT_15&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print4.reset(); 				

    		//ds_print5.�����������
			//ds_print5.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR5_PRT_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print5.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR5_PRT_15&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print5.reset(); 
    		
    		
            //�λ� �⺻���� 
    		row = ds_print.rowposition;
			row2 = ds_print2.rowposition;

			ds_print.namevalue(row,"EMPNO")      = ds_print2.namevalue(1,"ENO_NO")
			ds_print.namevalue(row,"EMPNMK")     = ds_print2.namevalue(1,"ENO_NM");
			ds_print.namevalue(row,"EMPJUNO")    = ds_print2.namevalue(1,"CET_NO");
			ds_print.namevalue(row,"HOL_YN")   	 = ds_print2.namevalue(1,"HOL_YN"); //�����ֿ���
			ds_print.namevalue(row,"WORKDAY")    = ds_print2.namevalue(1,"WORKDAY"); //�ٹ��Ⱓ
			ds_print.namevalue(row,"CLS_TAG")    = ds_print2.namevalue(1,"CLS_TAG");
			ds_print.namevalue(row,"ADDRESS")    = ds_print2.namevalue(1,"ADDRESS");
			ds_print.namevalue(row,"TELNO")    	 = ds_print2.namevalue(1,"TELNO");		
		
			ds_print.namevalue(row,"LUN_CHK")    = ds_print2.namevalue(1,"LUN_CHK");		
			ds_print.namevalue(row,"INS_TAG")    = ds_print2.namevalue(1,"INS_TAG");	
			
			ds_print.namevalue(row,"CNT")    = ds_print2.namevalue(1,"CNT");	
			
	        var dblref10=0;			
	        var dblref11=0;
			var dblref12=0;
			var dblref13=0;
			var dblref14=0;
			var dblref15=0;
			var dblref16=0;
	        var dblref17=0; 
			var dblref18=0;
	        var dblref19=0; 	        
	    
			var dblref20=0;	        
			var dblref21=0;
			var dblref22=0;
			var dblref23=0;
			var dblref24=0;
			var dblref25=0;
			var dblref27=0;
			var dblref28=0;
			var dblref29=0;	

			for(i=1;i<=ds_print3.countrow;i++){
	         
	          ds_print.namevalue(row,"RELAT1_"+i)   = ds_print3.namevalue(i,"REL_CD");
		      ds_print.namevalue(row,"EMPNMK_"+i)  = ds_print3.namevalue(i,"NAM_KOR");
			  ds_print.namevalue(row,"EMPJUNO_"+i) = ds_print3.namevalue(i,"CET_NO");

			  if(ds_print3.namevalue(i,"REF1")=="1")
				  ds_print.namevalue(row,"REF1_"+i)="1"; //������
			  else 
				  ds_print.namevalue(row,"REF1_"+i)="9"; //�ܱ���

			  if(ds_print3.namevalue(i,"REF2")=="O")
				  ds_print.namevalue(row,"REF2_"+i)="O"; //�⺻����
			  else 
				  ds_print.namevalue(row,"REF2_"+i)="";

			  if(ds_print3.namevalue(i,"REF3")=="O")
				  ds_print.namevalue(row,"REF3_"+i)="O"; //�γ���
			  else 
				  ds_print.namevalue(row,"REF3_"+i)="";

			  if(ds_print3.namevalue(i,"REF4")=="O")
				  ds_print.namevalue(row,"REF4_"+i)="O"; //�Ѻθ�
			  else 
				  ds_print.namevalue(row,"REF4_"+i)=""; 

	          if(ds_print3.namevalue(i,"REF5")=="O")
				ds_print.namevalue(row,"REF5_"+i)="O"; //��ο��
			  else 
				ds_print.namevalue(row,"REF5_"+i)="";

			 if(ds_print3.namevalue(i,"REF6")=="O")
				ds_print.namevalue(row,"REF6_"+i)="O"; //�����
			 else 
				ds_print.namevalue(row,"REF6_"+i)="";
			 
			 if(ds_print3.namevalue(i,"REF7")=="O")
				ds_print.namevalue(row,"REF7_"+i)="O"; //����Ծ�
			 else 
				ds_print.namevalue(row,"REF7_"+i)="";
			 
			 if(ds_print3.namevalue(i,"REF8")=="O")
				ds_print.namevalue(row,"REF8_"+i)="O"; //6������
			 else 
				ds_print.namevalue(row,"REF8_"+i)="";
			 
			 

			  ds_print.namevalue(row,"REF10_"+i)=ds_print3.namevalue(i,"REF10");
			  ds_print.namevalue(row,"REF11_"+i)=ds_print3.namevalue(i,"REF11");
			  ds_print.namevalue(row,"REF12_"+i)=ds_print3.namevalue(i,"REF12");
			  ds_print.namevalue(row,"REF13_"+i)=ds_print3.namevalue(i,"REF13");
			  ds_print.namevalue(row,"REF14_"+i)=ds_print3.namevalue(i,"REF14");
			  ds_print.namevalue(row,"REF15_"+i)=ds_print3.namevalue(i,"REF15");
			  ds_print.namevalue(row,"REF16_"+i)=ds_print3.namevalue(i,"REF16");
			  ds_print.namevalue(row,"REF17_"+i)=ds_print3.namevalue(i,"REF17");
			  ds_print.namevalue(row,"REF18_"+i)=ds_print3.namevalue(i,"REF18");
			  ds_print.namevalue(row,"REF19_"+i)=ds_print3.namevalue(i,"REF19");

			  //ds_print.namevalue(row,"REF20_"+i)=ds_print3.namevalue(i,"REF20");
			  ds_print.namevalue(row,"REF21_"+i)=ds_print3.namevalue(i,"REF21");
			  ds_print.namevalue(row,"REF22_"+i)=ds_print3.namevalue(i,"REF22");
			  ds_print.namevalue(row,"REF23_"+i)=ds_print3.namevalue(i,"REF23");
			  ds_print.namevalue(row,"REF24_"+i)=ds_print3.namevalue(i,"REF24");
			  ds_print.namevalue(row,"REF25_"+i)=ds_print3.namevalue(i,"REF25");
			  ds_print.namevalue(row,"REF27_"+i)=ds_print3.namevalue(i,"REF27");			  
			  ds_print.namevalue(row,"REF28_"+i)=ds_print3.namevalue(i,"REF28");
			  ds_print.namevalue(row,"REF29_"+i)=ds_print3.namevalue(i,"REF29");
			  //alert(ds_print3.namevalue(i,"REF13"));

			  dblref10 += parseInt(ds_print3.namevalue(i,"REF10"));			  
			  dblref11 += parseInt(ds_print3.namevalue(i,"REF11"));
			  dblref12 += parseInt(ds_print3.namevalue(i,"REF12"));
			  dblref13 += parseInt(ds_print3.namevalue(i,"REF13"));
			  dblref14 += parseInt(ds_print3.namevalue(i,"REF14"));
			  dblref15 += parseInt(ds_print3.namevalue(i,"REF15"));
			  dblref16 += parseInt(ds_print3.namevalue(i,"REF16"));
			  dblref17 += parseInt(ds_print3.namevalue(i,"REF17"));
			  dblref18 += parseInt(ds_print3.namevalue(i,"REF18"));
			  dblref19 += parseInt(ds_print3.namevalue(i,"REF19"));

	  
			  dblref21 += parseInt(ds_print3.namevalue(i,"REF21"));
			  dblref22 += parseInt(ds_print3.namevalue(i,"REF22"));
			  dblref23 += parseInt(ds_print3.namevalue(i,"REF23"));
			  dblref24 += parseInt(ds_print3.namevalue(i,"REF24"));
	          dblref25 += parseInt(ds_print3.namevalue(i,"REF25"));
			  dblref27 += parseInt(ds_print3.namevalue(i,"REF27"));
	          dblref28 += parseInt(ds_print3.namevalue(i,"REF28"));
			  dblref29 += parseInt(ds_print3.namevalue(i,"REF29"));			
  
			}

        	ds_print.namevalue(row,"REF10_S") = dblref10;  //�����(�ǰ� ����)        
	        ds_print.namevalue(row,"REF11_S") = dblref11;  //�����(���强)
			ds_print.namevalue(row,"REF12_S") = dblref12;  //�Ƿ��
			ds_print.namevalue(row,"REF13_S") = dblref13;  //������
			ds_print.namevalue(row,"REF14_S") = dblref14;  //�ſ�ī��
			ds_print.namevalue(row,"REF15_S") = dblref15;  //����ī��
			ds_print.namevalue(row,"REF16_S") = dblref16;  //���ݿ�����
	        ds_print.namevalue(row,"REF17_S") = dblref17;  //�������
			ds_print.namevalue(row,"REF18_S") = dblref18;  //���߱���
	        ds_print.namevalue(row,"REF19_S") = dblref19;  //��α�	        
	        
     
			ds_print.namevalue(row,"REF21_S") = dblref21;  //�����(���强)
			ds_print.namevalue(row,"REF22_S") = dblref22;  //�Ƿ��            
			ds_print.namevalue(row,"REF23_S") = dblref23;  //������            
			ds_print.namevalue(row,"REF24_S") = dblref24;  //�ſ�ī��          
			ds_print.namevalue(row,"REF25_S") = dblref25;  //����ī��    
			ds_print.namevalue(row,"REF27_S") = dblref27;  //�������			
			ds_print.namevalue(row,"REF28_S") = dblref28;  //���߱���    
			ds_print.namevalue(row,"REF29_S") = dblref29;  //��α�				
			
			/*���ݺ�������*/
	        ds_print.namevalue(row,"JAQ_AMT") 	= ds_print4.namevalue(1,"JAQ_AMT");//�����ٹ���(���ο���)
			ds_print.namevalue(row,"NPEN_AMT") 	= ds_print4.namevalue(1,"NPEN_AMT");//���ٹ���(���ο���)
			ds_print.namevalue(row,"JAR_AMT") 	= ds_print4.namevalue(1,"JAR_AMT");//���� ���ο��ݿ�
			ds_print.namevalue(row,"PEN_SUM") 	= ds_print4.namevalue(1,"PEN_SUM");//���ݺ�����
			
			/*��������*/			
			ds_print.namevalue(row,"JAH_AMT") 	= ds_print4.namevalue(1,"JAH_AMT");//���� �ǰ�����
			ds_print.namevalue(row,"HEALTH_AMT") 	= ds_print4.namevalue(1,"HEALTH_AMT");//�� �ǰ�����
			ds_print.namevalue(row,"JAP_AMT")    		= ds_print4.namevalue(1,"JAP_AMT");   //����	��뺸��
			ds_print.namevalue(row,"HINS_AMT")    	= ds_print4.namevalue(1,"HINS_AMT");   //��	��뺸��			
			ds_print.namevalue(row,"HIN_SUM")    	= ds_print4.namevalue(1,"HIN_SUM");   //�����			
			/*�����ڱ�*/			
			ds_print.namevalue(row,"LH1_AMT") 	= ds_print4.namevalue(1,"LH1_AMT");//������ �����������Ա�
			ds_print.namevalue(row,"LH2_AMT") 	= ds_print4.namevalue(1,"LH2_AMT");//������ �����������Ա�
			ds_print.namevalue(row,"LH3_AMT") 	= ds_print4.namevalue(1,"LH3_AMT");//������
			ds_print.namevalue(row,"LH4_AMT") 	= ds_print4.namevalue(1,"LH4_AMT");//15��̸�
			ds_print.namevalue(row,"LH5_AMT") 	= ds_print4.namevalue(1,"LH5_AMT");//15��~29��
			ds_print.namevalue(row,"LH6_AMT") 	= ds_print4.namevalue(1,"LH6_AMT");//30���̻�
			ds_print.namevalue(row,"LH7_AMT") 	= ds_print4.namevalue(1,"LH7_AMT");//�����ݸ�
			ds_print.namevalue(row,"LH8_AMT") 	= ds_print4.namevalue(1,"LH8_AMT");//��Ÿ����			
			ds_print.namevalue(row,"LH9_AMT") 	= ds_print4.namevalue(1,"LH9_AMT");//2015���� ���� ���ġ(15���̻�) 		
			ds_print.namevalue(row,"LH10_AMT") 	= ds_print4.namevalue(1,"LH10_AMT");//2015���� �����Ǵº��ġ(15���̻�)			
			ds_print.namevalue(row,"LH11_AMT") 	= ds_print4.namevalue(1,"LH11_AMT");//2015���� ��Ÿ����(15���̻�)		
			ds_print.namevalue(row,"LH12_AMT") 	= ds_print4.namevalue(1,"LH12_AMT");//2015���� �����Ǵº��ġ(10~15��)			
			
			/*�׹���*/			
			ds_print.namevalue(row,"PER_AMT") 	= ds_print4.namevalue(1,"PER_AMT");//���ο�������
			ds_print.namevalue(row,"LHO_AMT") 	= ds_print4.namevalue(1,"LHO_AMT");//û������
			ds_print.namevalue(row,"LHR_AMT") 	= ds_print4.namevalue(1,"LHR_AMT");//�ٷ������ø�������
			ds_print.namevalue(row,"LHP_AMT") 	= ds_print4.namevalue(1,"LHP_AMT");//����û����������
			ds_print.namevalue(row,"VEN_AMT") 	= ds_print4.namevalue(1,"VEN_AMT");//2013�� ����
			ds_print.namevalue(row,"VEN2_AMT") 	= ds_print4.namevalue(1,"VEN2_AMT");//2014�� ����
			ds_print.namevalue(row,"VEN3_AMT") 	= ds_print4.namevalue(1,"VEN3_AMT");//2015�� ����
			ds_print.namevalue(row,"CARD_AMT") 	    = ds_print4.namevalue(1,"CARD_AMT");//�ſ�ī��
			ds_print.namevalue(row,"DIR_CARD_AMT") 	= ds_print4.namevalue(1,"DIR_CARD_AMT");//����ī��
			ds_print.namevalue(row,"CASH_AMT") 		= ds_print4.namevalue(1,"CASH_AMT");//���ݿ�����
			ds_print.namevalue(row,"MARKET_AMT") 	= ds_print4.namevalue(1,"MARKET_AMT");//�������
			ds_print.namevalue(row,"PUBLIC_AMT") 	= ds_print4.namevalue(1,"PUBLIC_AMT");//���߱���
			ds_print.namevalue(row,"CARD_SUM") 		= ds_print4.namevalue(1,"CARD_SUM");//ī�� �հ�	
			
			ds_print.namevalue(row,"CARD_2013_AMT") 	= ds_print4.namevalue(1,"CARD_2013_AMT");//2013�� ���� �ſ�ī��� ����
			ds_print.namevalue(row,"CARD_2014_AMT") 	= ds_print4.namevalue(1,"CARD_2014_AMT");//2014�� ���� �ſ�ī��� ����
			ds_print.namevalue(row,"CARD_2013_OVER") 	= ds_print4.namevalue(1,"CARD_2013_OVER");//2013�� ���� �߰������� ����
			ds_print.namevalue(row,"CARD_2015_FH_OVER") = ds_print4.namevalue(1,"CARD_2015_FH_OVER");//2015�� ��ݱ� ���� �߰������� ����
			ds_print.namevalue(row,"CARD_2015_AMT") 	= ds_print4.namevalue(1,"CARD_2015_AMT");//2015�� ���� �ſ�ī��� ����
			ds_print.namevalue(row,"CARD_2014_OVER") 	= ds_print4.namevalue(1,"CARD_2014_OVER");//2014�� ���� �߰������� ����
			ds_print.namevalue(row,"CARD_2015_SH_OVER") = ds_print4.namevalue(1,"CARD_2015_SH_OVER");//2015�� �Ϲݱ� ���� �߰������� ����
			
			ds_print.namevalue(row,"SAJU_AMT") 			= ds_print4.namevalue(1,"SAJU_AMT");//�츮���������⿬��					
			ds_print.namevalue(row,"LSS_AMT") 			= ds_print4.namevalue(1,"LSS_AMT");//�������������������
		
			/*���ݰ���, �����*/				
			ds_print.namevalue(row,"DCIRP_AMT") 	= ds_print4.namevalue(1,"DCIRP_AMT");//��������
			ds_print.namevalue(row,"ANN_AMT") 		= ds_print4.namevalue(1,"ANN_AMT");//��������
			ds_print.namevalue(row,"DCANN_SUM") 	= ds_print4.namevalue(1,"DCANN_SUM");//���ݰ��°�
			
			
			ds_print.namevalue(row,"LIN_AMT") 		= ds_print4.namevalue(1,"LIN_AMT");//���强����
			ds_print.namevalue(row,"LIH_AMT") 		= ds_print4.namevalue(1,"LIH_AMT");//��������뺸��		
			ds_print.namevalue(row,"LI_SUM") 			= ds_print4.namevalue(1,"LI_SUM");//������		

			/*�Ƿ��*/		
			ds_print.namevalue(row,"HEA_AMT") 		= ds_print4.namevalue(1,"HEA_AMT");//����, ���, ������Ƿ��
			ds_print.namevalue(row,"OHEA_AMT") 		= ds_print4.namevalue(1,"OHEA_AMT");//�׹���	
			ds_print.namevalue(row,"HEA_SUM") 		= ds_print4.namevalue(1,"HEA_SUM");//�Ƿ�� �հ�

			/*������	*/	
			ds_print.namevalue(row,"TAG1_CNT") 		= ds_print4.namevalue(1,"TAG1_CNT");//������
			ds_print.namevalue(row,"TAG2_CNT") 		= ds_print4.namevalue(1,"TAG2_CNT");//���߰�	
			ds_print.namevalue(row,"TAG3_CNT") 		= ds_print4.namevalue(1,"TAG3_CNT");//���л�			
			ds_print.namevalue(row,"TAG4_CNT") 		= ds_print4.namevalue(1,"TAG4_CNT");//�����
			ds_print.namevalue(row,"GRA_AMT") 		= ds_print4.namevalue(1,"GRA_AMT");//�׹���
			ds_print.namevalue(row,"EDU_AMT1") 		= ds_print4.namevalue(1,"EDU_AMT1");//������
			ds_print.namevalue(row,"EDU_AMT2") 		= ds_print4.namevalue(1,"EDU_AMT2");//���߰�	
			ds_print.namevalue(row,"EDU_AMT3") 		= ds_print4.namevalue(1,"EDU_AMT3");//���л�		
			ds_print.namevalue(row,"HED_AMT") 		= ds_print4.namevalue(1,"HED_AMT");//�����				
			ds_print.namevalue(row,"EDU_SUM") 		= ds_print4.namevalue(1,"EDU_SUM");//������ �հ�		

			/*��α�	*/	
			ds_print.namevalue(row,"GOV1_AMT") 		= ds_print4.namevalue(1,"GOV1_AMT");//��ġ�ڱ�1
			ds_print.namevalue(row,"GOV2_AMT") 		= ds_print4.namevalue(1,"GOV2_AMT");//��ġ�ڱ�2
			ds_print.namevalue(row,"LC1_AMT") 		= ds_print4.namevalue(1,"LC1_AMT"); //������α�			
			ds_print.namevalue(row,"LC2_AMT") 		= ds_print4.namevalue(1,"LC2_AMT"); //������α�(������)
			ds_print.namevalue(row,"LC3_AMT") 		= ds_print4.namevalue(1,"LC3_AMT"); //������α�(����)
			ds_print.namevalue(row,"LC4_AMT") 		= ds_print4.namevalue(1,"LC4_AMT"); //�츮�������ձ�α�
			ds_print.namevalue(row,"LCC_SUM") 		= ds_print4.namevalue(1,"LCC_SUM"); //��α��հ�			
			
			/*�̿���α�*/
			
			ds_print.namevalue(row,"IW_LC1") 		= ds_print4.namevalue(1,"IW_LC1"); //�̿�����		
			ds_print.namevalue(row,"IW_LC2") 		= ds_print4.namevalue(1,"IW_LC2"); //�̿�������	
			ds_print.namevalue(row,"IW_LC3") 		= ds_print4.namevalue(1,"IW_LC3"); //�̿�����	
			
			ds_print.namevalue(row,"MM") 		    	= ds_print4.namevalue(1,"TODAY").substring(4,6);//����				
			ds_print.namevalue(row,"DD") 		    	= ds_print4.namevalue(1,"TODAY").substring(6,8);//����		

			
			//��������
			var no1 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="11"){
					  ds_print.namevalue(row,"DUDGBNM1_"+no1)="Ȯ���⿩��(DC)"										//
					  ds_print.namevalue(row,"FINANM1_"+no1)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO1_"+no1)	=ds_print5.namevalue(i,"ACCNO");				    //���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT1_"+no1)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT1_"+no1)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no1++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="12"){
					  ds_print.namevalue(row,"DUDGBNM1_"+no1)	="������(IRP)";									//
					  ds_print.namevalue(row,"FINANM1_"+no1)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO1_"+no1)	    =ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT1_"+no1)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT1_"+no1)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no1++;
					}
			}
			
			
			//���ݵ���
			var no2 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="21"){
					  ds_print.namevalue(row,"DUDGBNM2_"+no2)="���ο�������";										//���ο�������
					  ds_print.namevalue(row,"FINANM2_"+no2)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO2_"+no2)	=ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT2_"+no2)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT2_"+no2)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no2++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="22"){
					  ds_print.namevalue(row,"DUDGBNM2_"+no2)	="��������";											//��������
					  ds_print.namevalue(row,"FINANM2_"+no2)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO2_"+no2)	=ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT2_"+no2)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT2_"+no2)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no2++;
					}
			}

			var no3 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="31"){
					  ds_print.namevalue(row,"DUDGBNM3_"+no3)="û������";												//û������
					  ds_print.namevalue(row,"FINANM3_"+no3)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO3_"+no3)	=ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT3_"+no3)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT3_"+no3)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no3++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="32"){
					  ds_print.namevalue(row,"DUDGBNM3_"+no3)="����û����������";									//����û����������
					  ds_print.namevalue(row,"FINANM3_"+no3)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO3_"+no3)	=ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT3_"+no3)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT3_"+no3)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no3++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="34"){
					  ds_print.namevalue(row,"DUDGBNM3_"+no3)="�ٷ������ø�������";								//�ٷ������ø�������
					  ds_print.namevalue(row,"FINANM3_"+no3)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO3_"+no3)	=ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"PAYAMT3_"+no3)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT3_"+no3)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no3++;
					}
			}

			var no4 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="51"){																	//�������������������
					  ds_print.namevalue(row,"FINANM4_"+no4)	=ds_print5.namevalue(i,"FINANM");				//���������ȣ
					  ds_print.namevalue(row,"ACCNO4_"+no4)	=ds_print5.namevalue(i,"ACCNO");				//���¹�ȣ
					  ds_print.namevalue(row,"YEARLY4_"+no4)	=ds_print5.namevalue(i,"YEARLY");				//���Կ���
					  ds_print.namevalue(row,"PAYAMT4_"+no4)	=ds_print5.namevalue(i,"PAYAMT");				//���Աݾ�
					  ds_print.namevalue(row,"DEDAMT4_"+no4)	=ds_print5.namevalue(i,"DEDAMT");				//�����ݾ�
					  no4++;
					}
			}

			gcrp_print.Preview();			
			
        }

        /******************************************************************************
        	Description : ���format
        ******************************************************************************/
        	function ln_Rpt_SetDataHeader(){ //��¹� ����Ÿ ����� ����
        		
        		var ls_temp = "";
        	
        		if (ds_print.countrow<1){
        			
        			ds_print.SetDataHeader(ls_temp);
        			
			        ls_temp1 = "EMPNO:STRING(7),EMPNMK:STRING(20),EMPJUNO:STRING(14),MM:STRING(2),DD:STRING(2),ADDRESS:STRING(50),TELNO:STRING(15),"
			
			        + "EMPJUNO1:STRING(1),EMPJUNO2:STRING(1),EMPJUNO3:STRING(1),EMPJUNO4:STRING(1),EMPJUNO5:STRING(1),EMPJUNO6:STRING(1),EMPJUNO7:STRING(1),EMPJUNO8:STRING(1),"
			
			        + "ADDRESS:STRING(120),TELNO:STRING(15),HOL_YN:STRING(50),WORKDAY:STRING(50),CLS_TAG:STRING(80),LUN_CHK:STRING(30),INS_TAG:STRING(30),"     
			        + "REF10_S:DECIMAL(9.0),REF11_S:DECIMAL(9.0),REF12_S:DECIMAL(9.0),REF13_S:DECIMAL(9.0),REF14_S:DECIMAL(9.0),REF15_S:DECIMAL(9.0),REF16_S:DECIMAL(9.0),REF17_S:DECIMAL(9.0),REF18_S:DECIMAL(9.0),REF19_S:DECIMAL(9.0),"
			        + "REF21_S:DECIMAL(9.0),REF22_S:DECIMAL(9.0),REF23_S:DECIMAL(9.0),REF24_S:DECIMAL(9.0),REF25_S:DECIMAL(9.0),REF27_S:DECIMAL(9.0),REF28_S:DECIMAL(9.0),REF29_S:DECIMAL(9.0),"
			        + "CNT:INT(2),"	
			        
			        + "EMPNMK_1:STRING(20),EMPJUNO_1:STRING(13),"			        
			        + "RELAT1_1:STRING(1),REF1_1:STRING(1),REF2_1:STRING(1),REF3_1:STRING(1),REF4_1:STRING(1),REF5_1:STRING(1),REF6_1:STRING(1),REF7_1:STRING(1),REF8_1:STRING(1),"
			        + "REF10_1:DECIMAL(9.0),REF11_1:DECIMAL(9.0),REF12_1:DECIMAL(9.0),REF13_1:DECIMAL(9.0),REF14_1:DECIMAL(9.0),REF15_1:DECIMAL(9.0),REF16_1:DECIMAL(9.0),REF17_1:DECIMAL(9.0),REF18_1:DECIMAL(9.0),REF19_1:DECIMAL(9.0),"
			        + "REF21_1:DECIMAL(9.0),REF22_1:DECIMAL(9.0),REF23_1:DECIMAL(9.0),REF24_1:DECIMAL(9.0),REF25_1:DECIMAL(9.0),REF27_1:DECIMAL(9.0),REF28_1:DECIMAL(9.0),REF29_1:DECIMAL(9.0),"
			        
			        + "EMPNMK_2:STRING(20),EMPJUNO_2:STRING(13),"
			        + "RELAT1_2:STRING(1),REF1_2:STRING(1),REF2_2:STRING(1),REF3_2:STRING(1),REF4_2:STRING(1),REF5_2:STRING(1),REF6_2:STRING(1),REF7_2:STRING(1),REF8_2:STRING(1),"
			        + "REF11_2:DECIMAL(9.0),REF12_2:DECIMAL(9.0),REF13_2:DECIMAL(9.0),REF14_2:DECIMAL(9.0),REF15_2:DECIMAL(9.0),REF16_2:DECIMAL(9.0),REF17_2:DECIMAL(9.0),REF18_2:DECIMAL(9.0),REF19_2:DECIMAL(9.0),"
			        + "REF21_2:DECIMAL(9.0),REF22_2:DECIMAL(9.0),REF23_2:DECIMAL(9.0),REF24_2:DECIMAL(9.0),REF25_2:DECIMAL(9.0),REF27_2:DECIMAL(9.0),REF28_2:DECIMAL(9.0),REF29_2:DECIMAL(9.0),"
			        
			        + "EMPNMK_3:STRING(20),EMPJUNO_3:STRING(13),"
			        + "RELAT1_3:STRING(1),REF1_3:STRING(1),REF2_3:STRING(1),REF3_3:STRING(1),REF4_3:STRING(1),REF5_3:STRING(1),REF6_3:STRING(1),REF7_3:STRING(1),REF8_3:STRING(1),"
			        + "REF11_3:DECIMAL(9.0),REF12_3:DECIMAL(9.0),REF13_3:DECIMAL(9.0),REF14_3:DECIMAL(9.0),REF15_3:DECIMAL(9.0),REF16_3:DECIMAL(9.0),REF17_3:DECIMAL(9.0),REF18_3:DECIMAL(9.0),REF19_3:DECIMAL(9.0),"
			        + "REF21_3:DECIMAL(9.0),REF22_3:DECIMAL(9.0),REF23_3:DECIMAL(9.0),REF24_3:DECIMAL(9.0),REF25_3:DECIMAL(9.0),REF27_3:DECIMAL(9.0),REF28_3:DECIMAL(9.0),REF29_3:DECIMAL(9.0),"
			        
			        + "EMPNMK_4:STRING(20),EMPJUNO_4:STRING(13),"
			        + "RELAT1_4:STRING(1),REF1_4:STRING(1),REF2_4:STRING(1),REF3_4:STRING(1),REF4_4:STRING(1),REF5_4:STRING(1),REF6_4:STRING(1),REF7_4:STRING(1),REF8_4:STRING(1),"
			        + "REF11_4:DECIMAL(9.0),REF12_4:DECIMAL(9.0),REF13_4:DECIMAL(9.0),REF14_4:DECIMAL(9.0),REF15_4:DECIMAL(9.0),REF16_4:DECIMAL(9.0),REF17_4:DECIMAL(9.0),REF18_4:DECIMAL(9.0),REF19_4:DECIMAL(9.0),"
			        + "REF21_4:DECIMAL(9.0),REF22_4:DECIMAL(9.0),REF23_4:DECIMAL(9.0),REF24_4:DECIMAL(9.0),REF25_4:DECIMAL(9.0),REF27_4:DECIMAL(9.0),REF28_4:DECIMAL(9.0),REF29_4:DECIMAL(9.0),"
			        
			        + "EMPNMK_5:STRING(20),EMPJUNO_5:STRING(13),"
			        + "RELAT1_5:STRING(1),REF1_5:STRING(1),REF2_5:STRING(1),REF3_5:STRING(1),REF4_5:STRING(1),REF5_5:STRING(1),REF6_5:STRING(1),REF7_5:STRING(1),REF8_5:STRING(1),"
			        + "REF11_5:DECIMAL(9.0),REF12_5:DECIMAL(9.0),REF13_5:DECIMAL(9.0),REF14_5:DECIMAL(9.0),REF15_5:DECIMAL(9.0),REF16_5:DECIMAL(9.0),REF17_5:DECIMAL(9.0),REF18_5:DECIMAL(9.0),REF19_5:DECIMAL(9.0),"
			        + "REF21_5:DECIMAL(9.0),REF22_5:DECIMAL(9.0),REF23_5:DECIMAL(9.0),REF24_5:DECIMAL(9.0),REF25_5:DECIMAL(9.0),REF27_5:DECIMAL(9.0),REF28_5:DECIMAL(9.0),REF29_5:DECIMAL(9.0),"
			        
			        + "EMPNMK_6:STRING(20),EMPJUNO_6:STRING(13),"
			        + "RELAT1_6:STRING(1),REF1_6:STRING(1),REF2_6:STRING(1),REF3_6:STRING(1),REF4_6:STRING(1),REF5_6:STRING(1),REF6_6:STRING(1),REF7_6:STRING(1),REF8_6:STRING(1),"
			        + "REF11_6:DECIMAL(9.0),REF12_6:DECIMAL(9.0),REF13_6:DECIMAL(9.0),REF14_6:DECIMAL(9.0),REF15_6:DECIMAL(9.0),REF16_6:DECIMAL(9.0),REF17_6:DECIMAL(9.0),REF18_6:DECIMAL(9.0),REF19_6:DECIMAL(9.0),"
			        + "REF21_6:DECIMAL(9.0),REF22_6:DECIMAL(9.0),REF23_6:DECIMAL(9.0),REF24_6:DECIMAL(9.0),REF25_6:DECIMAL(9.0),REF27_6:DECIMAL(9.0),REF28_6:DECIMAL(9.0),REF29_6:DECIMAL(9.0),"
			        
			        + "EMPNMK_7:STRING(20),EMPJUNO_7:STRING(13),"
			        + "RELAT1_7:STRING(1),REF1_7:STRING(1),REF2_7:STRING(1),REF3_7:STRING(1),REF4_7:STRING(1),REF5_7:STRING(1),REF6_7:STRING(1),REF7_7:STRING(1),REF8_7:STRING(1),"
			        + "REF11_7:DECIMAL(9.0),REF12_7:DECIMAL(9.0),REF13_7:DECIMAL(9.0),REF14_7:DECIMAL(9.0),REF15_7:DECIMAL(9.0),REF16_7:DECIMAL(9.0),REF17_7:DECIMAL(9.0),REF18_7:DECIMAL(9.0),REF19_7:DECIMAL(9.0),"
			        + "REF21_7:DECIMAL(9.0),REF22_7:DECIMAL(9.0),REF23_7:DECIMAL(9.0),REF24_7:DECIMAL(9.0),REF25_7:DECIMAL(9.0),REF27_7:DECIMAL(9.0),REF28_7:DECIMAL(9.0),REF29_7:DECIMAL(9.0),"
			        
			        + "EMPNMK_8:STRING(20),EMPJUNO_8:STRING(13),"
			        + "RELAT1_8:STRING(1),REF1_8:STRING(1),REF2_8:STRING(1),REF3_8:STRING(1),REF4_8:STRING(1),REF5_8:STRING(1),REF6_8:STRING(1),REF7_8:STRING(1),REF8_8:STRING(1),"
			        + "REF11_8:DECIMAL(9.0),REF12_8:DECIMAL(9.0),REF13_8:DECIMAL(9.0),REF14_8:DECIMAL(9.0),REF15_8:DECIMAL(9.0),REF16_8:DECIMAL(9.0),REF17_8:DECIMAL(9.0),REF18_8:DECIMAL(9.0),REF19_8:DECIMAL(9.0),"
			        + "REF21_8:DECIMAL(9.0),REF22_8:DECIMAL(9.0),REF23_8:DECIMAL(9.0),REF24_8:DECIMAL(9.0),REF25_8:DECIMAL(9.0),REF27_8:DECIMAL(9.0),REF28_8:DECIMAL(9.0),REF29_8:DECIMAL(9.0),"

			        + "JAQ_AMT:DECIMAL(9.0),NPEN_AMT:DECIMAL(9.0),JAR_AMT:DECIMAL(9.0),PEN_SUM:DECIMAL(9.0),"
			        + "JAH_AMT:DECIMAL(9.0),HEALTH_AMT:DECIMAL(9.0),JAP_AMT:DECIMAL(9.0),HINS_AMT:DECIMAL(9.0),HIN_SUM:DECIMAL(9.0),"
			        + "LH1_AMT:DECIMAL(9.0),LH2_AMT:DECIMAL(9.0),LH3_AMT:DECIMAL(9.0),LH4_AMT:DECIMAL(9.0),"
			        + "LH5_AMT:DECIMAL(9.0),LH6_AMT:DECIMAL(9.0),LH7_AMT:DECIMAL(9.0),LH8_AMT:DECIMAL(9.0),"
			        + "LH9_AMT:DECIMAL(9.0),LH10_AMT:DECIMAL(9.0),LH11_AMT:DECIMAL(9.0),LH12_AMT:DECIMAL(9.0),LH_SUM:DECIMAL(9.0),"
			        + "PER_AMT:DECIMAL(9.0),LHO_AMT:DECIMAL(9.0),LHR_AMT:DECIMAL(9.0),LHP_AMT:DECIMAL(9.0),"
			        + "VEN_AMT:DECIMAL(9.0),VEN2_AMT:DECIMAL(9.0),VEN3_AMT:DECIMAL(9.0),"
			        + "CARD_AMT:DECIMAL(9.0),DIR_CARD_AMT:DECIMAL(9.0),CASH_AMT:DECIMAL(9.0),MARKET_AMT:DECIMAL(9.0),PUBLIC_AMT:DECIMAL(9.0),CARD_SUM:DECIMAL(9.0),"
			        + "CARD_2013_AMT:DECIMAL(9.0),CARD_2014_AMT:DECIMAL(9.0),CARD_2013_OVER:DECIMAL(9.0),CARD_2015_FH_OVER:DECIMAL(9.0),"
			        + "CARD_2015_AMT:DECIMAL(9.0),CARD_2014_OVER:DECIMAL(9.0),CARD_2015_SH_OVER:DECIMAL(9.0),"
			        + "SAJU_AMT:DECIMAL(9.0),LSS_AMT:DECIMAL(9.0),DCIRP_AMT:DECIMAL(9.0),ANN_AMT:DECIMAL(9.0),DCANN_SUM:DECIMAL(9.0),LIN_AMT:DECIMAL(9.0),LIH_AMT:DECIMAL(9.0),LI_SUM:DECIMAL(9.0),HEA_AMT:DECIMAL(9.0),OHEA_AMT:DECIMAL(9.0),HEA_SUM:DECIMAL(9.0),"
			        + "TAG1_CNT:STRING(5),TAG2_CNT:STRING(5),TAG3_CNT:STRING(5),TAG4_CNT:STRING(5),"			        
			        + "GRA_AMT:DECIMAL(9.0),EDU_AMT1:DECIMAL(9.0),EDU_AMT2:DECIMAL(9.0),EDU_AMT3:DECIMAL(9.0),HED_AMT:DECIMAL(9.0),EDU_SUM:DECIMAL(9.0),"
			        + "GOV1_AMT:DECIMAL(9.0),GOV2_AMT:DECIMAL(9.0),LC1_AMT:DECIMAL(9.0),LC2_AMT:DECIMAL(9.0),LC3_AMT:DECIMAL(9.0),LC4_AMT:DECIMAL(9.0),LCC_SUM:DECIMAL(9.0),"	
			        + "IW_LC1:DECIMAL(9.0),IW_LC2:DECIMAL(9.0),IW_LC3:DECIMAL(9.0),"
			        + "DUDGBNM1_1:STRING(30),FINANM1_1:STRING(50),ACCNO1_1:STRING(20),PAYAMT1_1:DECIMAL(9.0),DEDAMT1_1:DECIMAL(9.0),"
			        + "DUDGBNM1_2:STRING(30),FINANM1_2:STRING(50),ACCNO1_2:STRING(20),PAYAMT1_2:DECIMAL(9.0),DEDAMT1_2:DECIMAL(9.0),"
			        + "DUDGBNM1_3:STRING(30),FINANM1_3:STRING(50),ACCNO1_3:STRING(20),PAYAMT1_3:DECIMAL(9.0),DEDAMT1_3:DECIMAL(9.0),"
			        + "DUDGBNM2_1:STRING(30),FINANM2_1:STRING(50),ACCNO2_1:STRING(20),PAYAMT2_1:DECIMAL(9.0),DEDAMT2_1:DECIMAL(9.0),"
			        + "DUDGBNM2_2:STRING(30),FINANM2_2:STRING(50),ACCNO2_2:STRING(20),PAYAMT2_2:DECIMAL(9.0),DEDAMT2_2:DECIMAL(9.0),"
			        + "DUDGBNM2_3:STRING(30),FINANM2_3:STRING(50),ACCNO2_3:STRING(20),PAYAMT2_3:DECIMAL(9.0),DEDAMT2_3:DECIMAL(9.0),"
			        + "DUDGBNM2_4:STRING(30),FINANM2_4:STRING(50),ACCNO2_4:STRING(20),PAYAMT2_4:DECIMAL(9.0),DEDAMT2_4:DECIMAL(9.0),"
			        + "DUDGBNM2_5:STRING(30),FINANM2_5:STRING(50),ACCNO2_5:STRING(20),PAYAMT2_5:DECIMAL(9.0),DEDAMT2_5:DECIMAL(9.0),"
			        + "DUDGBNM3_1:STRING(30),FINANM3_1:STRING(50),ACCNO3_1:STRING(20),PAYAMT3_1:DECIMAL(9.0),DEDAMT3_1:DECIMAL(9.0),"
			        + "DUDGBNM3_2:STRING(30),FINANM3_2:STRING(50),ACCNO3_2:STRING(20),PAYAMT3_2:DECIMAL(9.0),DEDAMT3_2:DECIMAL(9.0),"
			        + "DUDGBNM3_3:STRING(30),FINANM3_3:STRING(50),ACCNO3_3:STRING(20),PAYAMT3_3:DECIMAL(9.0),DEDAMT3_3:DECIMAL(9.0),"
			        + "DUDGBNM3_4:STRING(30),FINANM3_4:STRING(50),ACCNO3_4:STRING(20),PAYAMT3_4:DECIMAL(9.0),DEDAMT3_4:DECIMAL(9.0),"
			        + "DUDGBNM3_5:STRING(30),FINANM3_5:STRING(50),ACCNO3_5:STRING(20),PAYAMT3_5:DECIMAL(9.0),DEDAMT3_5:DECIMAL(9.0),"	
			        + "FINANM4_1:STRING(50),ACCNO4_1:STRING(20),PAYAMT4_1:DECIMAL(9.0),DEDAMT4_1:DECIMAL(9.0),"
			        + "FINANM4_2:STRING(50),ACCNO4_2:STRING(20),PAYAMT4_2:DECIMAL(9.0),DEDAMT4_2:DECIMAL(9.0),"
			        + "FINANM4_3:STRING(50),ACCNO4_3:STRING(20),PAYAMT4_3:DECIMAL(9.0),DEDAMT4_3:DECIMAL(9.0),"
			        + "FINANM4_4:STRING(50),ACCNO4_4:STRING(20),PAYAMT4_4:DECIMAL(9.0),DEDAMT4_4:DECIMAL(9.0)";			        
			        
        			ds_print.SetDataHeader(ls_temp1);
        		}
        	}
        

        
        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
        	
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("���������ڷ���", '', 225);
            
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
        	
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETACC.ClearData();
            dsT_AC_FAMILY.ClearData();    //�ξ簡������ clear
            
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
        	
			window.close();

        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
        	
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
            
        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         * ok
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtPIS_YY_SHR").value = '2015';
            
            if(dsTemp != "Modal"){            
            //����� �α����� ������� ������ ���� �⺻������ �����´�.
            document.getElementById("txtENO_NO_SHR").value = gusrid;            
            document.getElementById("txtENO_NM_SHR").value = gusrnm;   
            }else{
            //����� ���޹��� ������� ������ ���� �⺻������ �����´�.
            document.getElementById("txtENO_NO_SHR").value = ENO_NO;            
            document.getElementById("txtENO_NM_SHR").value = '';
            fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');           	
            }
            

    		//�����ڰ� �ƴ� ��� Ÿ���� ��ȸ�� ���� �ʰ�
			if(gusrid != "6060002"  && gusrid != "2140002" && gusrid != "6070001" && gusrid != "2020008" && gusrid != "2070020"&& gusrid != "2030007"){
				
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNo");
	            document.getElementById("ImgEnoNo").style.display = "none";

	            fnc_ChangeStateElement(false, "txtADDRESS");
	            fnc_ChangeStateElement(false, "ImgZipNo");
	            //document.getElementById("ImgZipNo").style.display = "none";
				//document.getElementById("imgPrint").style.display = "none";
				
			}

            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";    		
    		
			//��������� �������� ����� �߰����� ����Ʈ�� �����´�.
            fnc_SearchList();

            fStyleGrid_New(form1.grdT_AC_FAMILY,0,"true","true");      // Grid Style ����
    		
    		
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == "N"){

				fnc_disableInput();
				
			}else{

				fnc_enableInput();
				
			}            
            
			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
				document.getElementById("chkCLS_TAG").checked = true;
			}else{
				document.getElementById("chkCLS_TAG").checked = false;
			}
			
			//alert(dsT_AC_RETACC.NameValue(1, "FUN_CNT") );
			
			//if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" ){
			//	alert("���������� �����Դϴ�.\n������ �Ұ����մϴ�.");
			//}




        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/
        /**
         * �������� �׸� ���� ����
         */
         
        function checkFamily(param) {

            var CLS_TAG;
            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
 
            if(document.getElementById("chkCLS_TAG").checked == true) {
            	CLS_TAG = 'Y';
            }else{
            	CLS_TAG = 'N';
            }

            // �������� �׸� ���� ����� ���� üũ
            params = "&S_MODE=SAV_CLS_15"
                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
            		+ "&CLS_TAG="+CLS_TAG
                    + "&PIS_YY="+PIS_YY;            		
            
            //DataSet�� �Է»��·� ����
            dsT_AC_RETACC.UseChangeInfo = false;

            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
            trT_AC_RETACC_SAV.action = dataClassName+params;
            trT_AC_RETACC_SAV.post();
            
        }

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {

        	fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','0');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {

            	fnc_SearchList();
            }
            
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
        	
            var obj = new String;
            
            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;

            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";

            }
        }

       function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
       }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }


        /********************************************
         * 									��������                         				*
         ********************************************/

        function fnc_Submit() {
        	
            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           
        	if(submit_chk == "N"||submit_chk == ""){

	            if(confirm("�������� �Ͻø� ���̻� �����Ͻ� �� �����ϴ�.\n�����Ͻðڽ��ϱ�?")) {
	
	                //�������� ��������
	                params = "&S_MODE=SAV_END_15"
	                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                   	    + "&SUBMIT_TAG=Y"
                        + "&PIS_YY="+PIS_YY;            	                   	    
	            
		            //DataSet�� �Է»��·� ����
		            dsT_AC_RETACC.UseChangeInfo = false;
		
		            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
		                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
		            trT_AC_RETACC_SAV.action = dataClassName+params;
		            trT_AC_RETACC_SAV.post();
		            
		            submit_chk == "Y"
		
		            }
        	}else{

				alert("�̹� ���������ϼ̽��ϴ�.");

				//������ ���
				if(gusrid == "6060002" || gusrid == "2140002" || gusrid == "6070001"||gusrid == "2020008"|| gusrid == "2070020"|| gusrid == "2030007") {

		            if(confirm("������̽ñ���.\n���������� ����Ͻðڽ��ϱ�?")) {

		                //�������� �������� ���
		                params = "&S_MODE=SAV_END_15"
		                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
	                   	    + "&SUBMIT_TAG=N"
	                        + "&PIS_YY="+PIS_YY;            		                   	    
                   	                
			            //DataSet�� �Է»��·� ����
			            dsT_AC_RETACC.UseChangeInfo = false;
			
			            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
			                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
			            trT_AC_RETACC_SAV.action = dataClassName+params;
			            trT_AC_RETACC_SAV.post();
		            	
					}
		            submit_chk = "N";
		            fnc_SearchList();
		
        		}

				return;
            }     
        	
    }
        
        /********************************************
         * �ξ簡������ �Լ�                        *  OK
         ********************************************/

        /* 01. ��ȸ �Լ�_List ������ ��ȸ  */
        function fnc_SearchList_01() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            //params_01 = "&S_MODE=SHR_142"
            params_01 = "&S_MODE=SHR_15"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO;

            dsT_AC_FAMILY.dataid = dataClassName_01+params_01;
            dsT_AC_FAMILY.reset();
         }


        /* 02. ���� �Լ�   */
        function fnc_Delete_01() {


            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
             if (dsT_AC_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
              }

             if(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "REL_NM") == "����"){
                alert("���� �ڷ�� ������ �� �����ϴ�.");
                return false;
             }

             // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
             if (confirm(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "NAM_KOR")+" [" + dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "CET_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

             //DataSet�� �Է»��·� ����
             dsT_AC_FAMILY.UseChangeInfo = false;

             var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
             var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

             var tmpCnt = dsT_AC_FAMILY.RowPosition-1;

             //params_01 = "&S_MODE=DEL_142"
             params_01 = "&S_MODE=DEL_15"
                     + "&PIS_YY="+PIS_YY
                     + "&ENO_NO="+ENO_NO
                     + "&ROW_ID="+tmpCnt;

             trT_AC_FAMILY.KeyValue = "TR_SAV(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
             trT_AC_FAMILY.Action = dataClassName_01+params_01;
             trT_AC_FAMILY.post();
             fnc_SearchList_01();
         }

         /* 03. �ʱ�ȭ �Լ�   */
          function fnc_Clear_01() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_FAMILY.ClearData();
          }



          /* 05.  �ξ簡�����׵��   */
          function fnc_RegFamily() {

              if(submit_chk == "Y"){
                  alert("���������ϼ̽��ϴ�.\n����ڿ��� ���ǹٶ��ϴ�.");
                  return;
              }  

            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
            var DPT_NM = document.getElementById("txtDPT_NM").value;
            var JOB_NM = document.getElementById("txtJOB_NM").value;
            var TAX_INCOME = document.getElementById("txtTAX_INCOME").value;
            
            
            var href_page = "yaca022_15.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO
                          + "&ENO_NM="+ENO_NM
                          + "&DPT_NM="+DPT_NM
                          + "&JOB_NM="+JOB_NM
                          + "&TAX_INCOME="+TAX_INCOME
                          + "&END_YN="+submit_chk                           
                          + "&gusrid="+gusrid;                          

            window.showModalDialog(href_page, "", "dialogWidth:700px; dialogHeight:945px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
           }

           /* 06.  ��������������   */
          function fnc_RegPension() {
        	   
          //alert("fnc_RegPension");

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;
           var TAX_INCOME = Number(dsT_AC_RETACC.namevalue(1,"TAX_INCOME2"));

           var href_page = "yaca060_15.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk 
                      + "&gusrid="+gusrid 
                      + "&TAX_INCOME="+TAX_INCOME    
           ;
           
           //prompt(this,href_page);

            window.showModalDialog(href_page, "", "dialogWidth:950px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            
           }


          /* 07.  �Ƿ��������   */
          function fnc_RegHospital(row) {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "yaca030_15.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&REL_CD="+dsT_AC_FAMILY.NameValue(row, "REL_CD")
                      + "&NAM_KOR="+dsT_AC_FAMILY.NameValue(row, "NAM_KOR")                          
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                      + "&TRB_MAN="+dsT_AC_FAMILY.NameValue(row, "TRB_MAN")                      
                      + "&END_YN="+submit_chk  
                      + "&gusrid="+gusrid                        
           ;
          
           //prompt(this,href_page);
            window.showModalDialog(href_page, "", "dialogWidth:950px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
          }
          
          /* 08.  ��αݰ������   */
          function fnc_RegDonation(row) {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "yaca040_15.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&REL_CD="+dsT_AC_FAMILY.NameValue(row, "REL_CD")
                      + "&NAM_KOR="+dsT_AC_FAMILY.NameValue(row, "NAM_KOR")                      
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")     
                      + "&END_YN="+submit_chk    
                      + "&gusrid="+gusrid                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:950px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();           
          }

          
          /* 09.  �����ٹ������   */
          function fnc_Dutyplace() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           
           //if(ENO_NO.substring(1,3) != '14'){
        	   
        	//   alert("�ߵ��Ի��ڰ� �ƴϽʴϴ�.\n�ߵ��Ի��ڸ� �Է��ϴ� �޴��Դϴ�.");
			//   return false;           
           //} 
           
  
           var href_page = "yaca023_15.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }
          
    </script>
</head>

<!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)           |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_RETACC_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<!-----------------------------------------------------+
    | �ξ簡�� ����                                         						|
    1 1. ��ȸ�� DataSet                                     			|
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_FAMILY)            |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                   	|
    +------------------------------------------------------->
<Object ID="dsT_AC_FAMILY_OLD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_MEDICAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
        <Param Name="SubsumExpr" 	  		Value="total">
</Object>

<Object ID="dsT_AC_DONATION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
</Object>

<object id=ds_print ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds_print2 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print3 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print4 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print5 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------+
    | �ξ簡�� ����                                        |
    1 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_FAMILY)           |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                  *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">


        if (iCount == 0)    {
            document.getElementById("resultMessage").innerText = "�ش� �ڷᰡ �������� �ʽ��ϴ�.";
            dsT_AC_RETACC.ClearData();
            dsT_CM_PERSON.ClearData();
            dsT_AC_FAMILY.ClearData();    //�ξ簡������ clear

        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            document.getElementById("resultMessage").innerText = "�ش� �ڷḦ ��ȸ�߽��ϴ�.";

            //�λ���ǥ ��ȸ
            dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR2_15&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            //prompt('dsT_CM_PERSON.dataid',dsT_CM_PERSON.dataid);
            dsT_CM_PERSON.reset();

        }
</Script>


<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
</Script>

<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
</Script>

<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
</Script>

<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
</Script>

<!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnSuccess()">
        //radio ��ư�� �����ϱ�
        fnc_CheckedElement("radHOL_YN", dsT_AC_RETACC.NameValue(1, "HOL_YN"));
        fnc_CheckedElement("radSOU_YN", dsT_AC_RETACC.NameValue(1, "SOU_YN"));
        fnc_CheckedElement("radWCT_YN", dsT_AC_RETACC.NameValue(1, "WCT_YN"));
</script>

<script for=trT_AC_RETACC_SAV event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
        fnc_SearchList();
</script>

<!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
</script>

<script for=trT_AC_RETACC_SAV event="OnFail()">
        cfErrorMsg(this);
</script>

<!-----------------------------------------------------+
    | Grid Head Check event ó��                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_RETACC event=OnHeadCheckClick(Col,Colid,bCheck)>
        //for(var i=1; i<=dsT_AC_RETACC.CountRow; i++) {
        //    dsT_AC_RETACC.NameValue(i, "STATUS") = bCheck;
        //}

</script>

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
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }
</Script>

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
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
        //fnc_SearchList();
</script>

<!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
<script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
</script>


<!-----------------------------------------------------+
    | Grid OnDblClick event ó��                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_FAMILY event=OnDblClick(row,colid)>



        var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
        var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
        var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
        var DPT_NM = document.getElementById("txtDPT_NM").value;
        var JOB_NM = document.getElementById("txtJOB_NM").value;
        
        if(colid != "MED_AMT" && colid != "LC_AMT"){
      	
	        var href_page = "yaca022_15.jsp"
	                      + "?TYPE=UPT"
	                      + "&PIS_YY="+PIS_YY
	                      + "&ENO_NO="+ENO_NO
                          + "&ENO_NM="+ENO_NM
                          + "&DPT_NM="+DPT_NM
                          + "&JOB_NM="+JOB_NM	                      
	                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                          + "&END_YN="+submit_chk        	                      
	                      + "&gusrid="+gusrid
	                      ;
	        
	        window.showModalDialog(href_page, "", "dialogWidth:700px; dialogHeight:945px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        }else if(colid == "MED_AMT"){
        	fnc_RegHospital(row);	
        }else if(colid == "LC_AMT"){
        	fnc_RegDonation(row);	        	
        }

        fnc_SearchList();
        
    </script>

<!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->


<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>



<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1050" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	<tr>
		<td valign="center" class="searchState"><span id="resultMessage">&nbsp;</span></td> 
		<td height="30" class="paddingTop5" align="right" valign="top">

		<a href="http://www.yesone.go.kr/index.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNts','','../../images/button/btn_NtsOver.gif',1)">
		<img src="../../images/button/btn_NtsOn.gif" name="imgNts" width="65" height="20" border="0" align="absmiddle"></a> 
		&nbsp;&nbsp;&nbsp;&nbsp; 		
		
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_submit.gif',1)">
		<img src="../../images/button/btn_submit.gif" name="imgSave" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>			
		&nbsp;&nbsp;&nbsp;	&nbsp;

		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)">
		<img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>

        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">
		<img src="../../images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> 

		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� --> 


<!-- power Search���̺� ���� --> 
<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="200"></col>
						<col width="80"></col>
						<col width="140"></col>
						<col width="200"></col>
						<col width="140"></col>												
						<col width=""></col>
					</colgroup>
					<tr>
						<td align="right" class="searchState">�� �� �� ��&nbsp;</td>
						<td class="padding2423">
 							<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly> 
						</td>
						<td align="right" class="searchState">��  ��&nbsp;</td>
						<td class="padding2423">
							<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
                            <!--<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="7" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"> 
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}">  -->
							<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle"
							onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							<input type="hidden" id="hidEMPL_DPT_CD">
						</td>
						<td align="right" class="searchState">���⿩��&nbsp;</td>						
						<td class="padding2423">
 							<input id="txtFUN_CNTNM" name="txtFUN_CNTNM" size="10" class="input_ReadOnly" readonly> 
						</td>						
					</tr>
				</table>
			</td>
		</tr>
</table>
<!-- power Search���̺� �� --> 

<br>

<!-- ���� �Է� ���̺� ���� -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width=""></col>
				</colgroup>
			<tr>
				<td align="center" class="blueBold">�� ��</td>
				<td class="padding2423">
				<input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="blueBold">�� ��</td>
				<td class="padding2423">
				<input id="txtJOB_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="blueBold">�����ȣ</td>
				<td class="padding2423">
				<input id="txtZIP_NO" size="10" maxlength="10" class="input_ReadOnly" readonly> 
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','/images/button/btn_HelpOver.gif',1)"></a>
				</td>
				<td align="center" class="blueBold">�� ��</td>
				<td class="padding2423">
				<input id="txtADR_CT" style="width:45%" class="input_ReadOnly" readonly> 
				<input id="txtADDRESS" maxlength="60" style="width:45%" class="input_ReadOnly" readonly> 
					<input type=hidden id="txtENO_NO"> 
					<input type=hidden id="txtHEAD_CD"> 
					<input type=hidden id="txtDPT_CD">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� --> 

<br>

<!--��ư���̺���� -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
			<tr>
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_1"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_RegFamily();"><font color="red"><b>�ξ簡���߰� Click!</b></font></button> 
	            </td>	 

	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_2"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_RegHospital();"><font color="red"><b>�Ƿ���Է� Click!</b></font></button> 
	            </td>	  
	            
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_3"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_RegDonation();"><font color="red"><b>��α��Է� Click!</b></font></button> 
	            </td>	  
	            	            
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_4"  style="cursor:hand;width:150pt;height:20pt;" onclick="fnc_RegPension();"><font color="red"><b>����/���ø�������  Click!</b></font></button> 
	            </td>	  	
	                        
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_5"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_Dutyplace();"><font color="red"><b>�����ٹ��� Click!</b></font></button> 
	            </td>	            
			</tr>			
</table>		
<!--��ư���̺� �� -->

	
		
<!--��ȸ���̺���� -->		
<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
	
				<!-- ��ȸ ���� ���̺� ���� -->
				<table width="1050" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="right" valign="center" class="searchState">
									<input type="checkbox" name="chkCLS_TAG" id="chkCLS_TAG" onclick="checkFamily(this)" style="border:0">&nbsp;�� ��
								</td>
									<td align="left" valign="center" class="searchState"><font color = "blue">���������� �׸��� ����� ������ ��쿡�� üũ</font>
								</td>
								<td align="right" valign="center" class="searchState">�ػ󼼳����� ���Ͻø� �ش系���� ����Ŭ��	</td>
								<td height="25" class="paddingTop5" align="right">
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)">
								<img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete_01()"></a>
								</td>								
							</tr>
				</table>
				<!-- ��ȸ ���� ���̺� �� --> 
				
				
				<!-- ���� ��ȸ �׸��� ���̺� ����-->
				<table width="1060" border="0" cellspacing="0" cellpadding="0">
							<tr align="center">
								<td>
								<comment id="__NSID__"> 
								<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1071px;height:480px;">						
									<param name="DataID" 				value="dsT_AC_FAMILY">
									<param name="Editable" 				value="false">
									<param name=HiddenHScroll    		value="true">
									<param name=TitleHeight             value="30">
									<param name="Format"				value='
                                          <FC> id=NO     			width=15        align=center       name=��                	suppress=2  </FC>
                                          <FC> id=REL_NM      		width=76      	align=left	       name=����              	suppress=2  multiline=true</FC>
                                          <FC> id=NAM_KOR     		width=43        align=left       	name=����              	suppress=2  </FC>
                                          <C> id=CET_NO       		width=90        align=center       name=�ֹι�ȣ          	suppress=2  </C>
                                          
                                          <C> id=BAS_MAN      		width=20        align=center       name="��;��;��;��"      suppress=2  </C>
                                          <C> id=GOL_70       		width=20        align=center       name="��;��"              	suppress=2  </C>
                                          <C> id=TRB_MAN      		width=20        align=center       name="��;��;��"        suppress=2  </C>
                                          <C> id=WCT_MAN      		width=20        align=center       name="��;��;��"         suppress=2  </C>
                                          <C> id=ONE_MAN      		width=20        align=center       name="��;��;��"         suppress=2  </C>
                                          
                                          <C> id=INP_MAN      		width=20        align=center       name="��;��;��;��"      suppress=2  </C>                                          
                                          <C> id=RCH_MAN      		width=20        align=center       name="6;��;��;��"      suppress=2  </C>                                          
                                          <C> id=GBN_NM       		width=32        align=left     		name=����                  </C>

                                          <G> name=�����    HeadBgColor=#dae0ee    TextColor=#34578c  HeadFontStyle = "bold"                                            
                                          <C> id=HIN_SUM      		width=60        align=right        name="�ǰ�/���"          </C>
                                          <C> id=LIN_AMT      		width=60        align=right        name=���强              </C>                                          
                                          </G>               
                                                                     
                                          <C> id=MED_AMT      		width=60        align=right        name=�Ƿ��              </C>
                                          <C> id=EDU_AMT      		width=60        align=right        name=������              </C>
                                           
                                          <G> name=�ſ�ī���    HeadBgColor=#dae0ee    TextColor=#34578c  HeadFontStyle = "bold"                              
                                          <C> id=CARD_AMT     		width=65       align=right        name="�ſ�ī��"   </C>
                                          <C> id=DIR_CARD_AMT 	    width=65       align=right        name="����/����"  </C>
                                          <C> id=CASH_AMT     		width=60       align=right        name="���ݿ�����"  </C>
                                          <C> id=MARKET_AMT     	width=60       align=right        name=�������   </C>
                                          <C> id=PUBLIC_AMT      	width=60       align=right        name="���߱���" </C>                                          
                                          </G>
                                          <C> id=LC_AMT      		width=61        align=right        name=��α�              </C>                                                                                   

					                   	'>
								</object> </comment><script> __ShowEmbedObject(__NSID__); </script>
							</td>
						</tr>
				</table>
				<!-- ���� ��ȸ �׸��� ���̺� ��-->
		</td>
	</tr>
</table>


<!--�ѱ޿� ǥ�� --> 
  
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
          <tr>
               <td class="padding2423">- <font color = "blue">�ѱٷμҵ��</font>��&nbsp;
                        <input name=txtSALT_AMT id=txtSALT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	���̸� ���� <font color = "blue">�����(�ҵ��)�ҵ�</font>�� 
                        <input name=txtFREE_INCOME id=txtFREE_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	���̰� <font color = "blue">�������޿�</font>��     
                        <input name=txtTAX_INCOME id=txtTAX_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	���Դϴ�.                                     
              </td>
         </tr>        
         <tr>
               <td class="padding2423">&nbsp;
                   <font color = "blue">�ҵ漼</font>&nbsp;
                   <input name=txtINCM_TAX id=txtINCM_TAX size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>&nbsp;&nbsp;
                   <font color = "blue">����ҵ漼</font>&nbsp;
                   <input name=txtCITI_TAX id=txtCITI_TAX size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>

              </td>
         </tr>          
</table>

<!--�ѱ޿� ǥ�� �� -->
</form>


<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### ���� �Ű� ####
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>

	<PARAM NAME="MasterDataID"			VALUE="ds_print">  
	<PARAM NAME="DetailDataID"			VALUE="ds_print">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="200">
	<param name="MargineX"              value="30">
	<param name="MargineY"              value="30">
	<PARAM NAME="Format" VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='ds_print'

<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=101 ,top=1180 ,right=1950 ,bottom=1180 </L>
	<L> left=101 ,top=1461 ,right=1950 ,bottom=1461 </L>
	<L> left=101 ,top=1601 ,right=1950 ,bottom=1601 </L>
	<L> left=101 ,top=1741 ,right=1950 ,bottom=1741 </L>
	<L> left=101 ,top=1881 ,right=1950 ,bottom=1881 </L>
	<L> left=101 ,top=2019 ,right=1950 ,bottom=2019 </L>
	<L> left=29 ,top=130 ,right=1950 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2799 ,right=1950 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=130 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1950 ,top=130 ,right=1950 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=209 ,right=1950 ,bottom=209 </L>
	<L> left=455 ,top=741 ,right=455 ,bottom=2159 </L>
	<L> left=579 ,top=669 ,right=579 ,bottom=2159 </L>
	<L> left=29 ,top=669 ,right=1950 ,bottom=669 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=347 ,top=743 ,right=347 ,bottom=2162 </L>
	<L> left=101 ,top=1320 ,right=1950 ,bottom=1320 </L>
	<L> left=101 ,top=1249 ,right=1950 ,bottom=1249 </L>
	<L> left=101 ,top=1389 ,right=1950 ,bottom=1389 </L>
	<L> left=101 ,top=1529 ,right=1950 ,bottom=1529 </L>
	<L> left=101 ,top=1670 ,right=1950 ,bottom=1670 </L>
	<L> left=101 ,top=1810 ,right=1950 ,bottom=1810 </L>
	<L> left=101 ,top=1950 ,right=1950 ,bottom=1950 </L>
	<L> left=101 ,top=2090 ,right=1950 ,bottom=2090 </L>
	<L> left=103 ,top=741 ,right=1950 ,bottom=741 </L>
	<L> left=101 ,top=669 ,right=101 ,bottom=2156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1691 ,top=804 ,right=1691 ,bottom=2159 </L>
	<L> left=1429 ,top=804 ,right=1429 ,bottom=2159 </L>
	<L> left=1561 ,top=804 ,right=1561 ,bottom=2159 </L>
	<L> left=26 ,top=2159 ,right=1950 ,bottom=2159 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1299 ,top=804 ,right=1299 ,bottom=2154 </L>
	<L> left=1169 ,top=741 ,right=1169 ,bottom=2162 </L>
	<L> left=1169 ,top=804 ,right=1820 ,bottom=804 </L>
	<L> left=101 ,top=820 ,right=579 ,bottom=820 </L>
	<L> left=169 ,top=1045 ,right=169 ,bottom=2159 </L>
	<L> left=405 ,top=1249 ,right=405 ,bottom=1323 </L>
	<L> left=405 ,top=1392 ,right=405 ,bottom=1461 </L>
	<L> left=405 ,top=1529 ,right=405 ,bottom=1598 </L>
	<L> left=405 ,top=1670 ,right=405 ,bottom=1738 </L>
	<L> left=405 ,top=1810 ,right=405 ,bottom=1879 </L>
	<L> left=405 ,top=1950 ,right=405 ,bottom=2019 </L>
	<L> left=654 ,top=804 ,right=910 ,bottom=804 </L>
	<L> left=1040 ,top=743 ,right=1040 ,bottom=2156 </L>
	<L> left=910 ,top=741 ,right=910 ,bottom=2154 </L>
	<L> left=651 ,top=738 ,right=651 ,bottom=2159 </L>
	<L> left=781 ,top=804 ,right=781 ,bottom=2154 </L>
	<L> left=98 ,top=1111 ,right=1950 ,bottom=1111 </L>
	<L> left=347 ,top=974 ,right=1950 ,bottom=974 </L>
	<L> left=103 ,top=908 ,right=1950 ,bottom=908 </L>
	<L> left=98 ,top=1045 ,right=1950 ,bottom=1045 </L>
	<L> left=172 ,top=741 ,right=172 ,bottom=908 </L>
	<X>left=169 ,top=1111 ,right=349 ,bottom=1180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1249 ,right=1561 ,bottom=1320 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1389 ,right=1561 ,bottom=1461 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1529 ,right=1561 ,bottom=1601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1950 ,right=1561 ,bottom=2019 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=2090 ,right=1561 ,bottom=2159 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1670 ,right=1561 ,bottom=1741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1810 ,right=1561 ,bottom=1881 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1111 ,right=1561 ,bottom=1180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=974 ,right=1561 ,bottom=1045 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��.' ,left=34 ,top=1262 ,right=95 ,bottom=1312 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1312 ,right=95 ,bottom=1352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1360 ,right=95 ,bottom=1400 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1408 ,right=95 ,bottom=1447 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1455 ,right=95 ,bottom=1495 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1548 ,right=95 ,bottom=1585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1635 ,right=95 ,bottom=1677 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1685 ,right=95 ,bottom=1725 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1733 ,right=95 ,bottom=1773 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1781 ,right=95 ,bottom=1818 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1873 ,right=95 ,bottom=1913 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1921 ,right=95 ,bottom=1958 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210��x297��' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<T>id='�� �ҵ漼�� �����Ģ [���� ��37ȣ ����]  <2015.05.13.����>' ,left=26 ,top=61 ,right=1058 ,bottom=122 ,align='left'</T>
	<T>id='(1��)' ,left=1791 ,top=66 ,right=1894 ,bottom=122 ,align='right'</T>
	<T>id='* �ٷμҵ��ڴ� �Ű��� �ҵ桤���� ���� �������� ÷���Ͽ� ��õ¡���ǹ���(�Ҽ� ȸ�� ��)���� �����ϸ�, ��õ¡���ǹ��ڴ� �Ű� �� ÷�μ����� Ȯ���Ͽ�' ,left=37 ,top=212 ,right=1886 ,bottom=246 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=101 ,top=855 ,right=169 ,bottom=886 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=101 ,top=823 ,right=169 ,bottom=855 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=106 ,top=751 ,right=167 ,bottom=783 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹε�Ϲ�ȣ' ,left=175 ,top=833 ,right=344 ,bottom=878 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�' ,left=106 ,top=781 ,right=167 ,bottom=815 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=180 ,top=767 ,right=336 ,bottom=812 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �׸�' ,left=159 ,top=675 ,right=542 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ҵ桤���� ���� �׸�' ,left=767 ,top=677 ,right=1640 ,bottom=736 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=579 ,top=831 ,right=651 ,bottom=870 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=579 ,top=913 ,right=651 ,bottom=966 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=582 ,top=984 ,right=651 ,bottom=1035 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=579 ,top=1111 ,right=651 ,bottom=1180 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=579 ,top=1180 ,right=651 ,bottom=1249 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=579 ,top=1249 ,right=651 ,bottom=1320 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=579 ,top=1320 ,right=651 ,bottom=1389 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=582 ,top=1461 ,right=651 ,bottom=1529 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=582 ,top=1529 ,right=651 ,bottom=1601 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=582 ,top=1601 ,right=651 ,bottom=1670 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=582 ,top=1389 ,right=651 ,bottom=1461 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=582 ,top=1670 ,right=651 ,bottom=1741 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=582 ,top=1741 ,right=651 ,bottom=1810 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=582 ,top=1810 ,right=651 ,bottom=1881 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=582 ,top=1881 ,right=651 ,bottom=1950 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����û' ,left=582 ,top=2019 ,right=651 ,bottom=2090 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=582 ,top=2090 ,right=651 ,bottom=2159 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ǻ���' ,left=42 ,top=2164 ,right=222 ,bottom=2193 ,align='left' ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� �� ���װ���' ,left=1294 ,top=751 ,right=1646 ,bottom=804 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=706 ,top=751 ,right=855 ,bottom=791 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����(�ڳ� :' ,left=106 ,top=995 ,right=267 ,bottom=1040 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��)' ,left=294 ,top=995 ,right=344 ,bottom=1040 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ϴ� �ο�����' ,left=101 ,top=953 ,right=349 ,bottom=995 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �׸�' ,left=106 ,top=908 ,right=336 ,bottom=953 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�ٷ��� ����)' ,left=172 ,top=1122 ,right=347 ,bottom=1167 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='����û' ,left=579 ,top=1050 ,right=651 ,bottom=1111 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1831 ,top=759 ,right=1942 ,bottom=886 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���߱���' ,left=1701 ,top=815 ,right=1807 ,bottom=852 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�̿��' ,left=1715 ,top=849 ,right=1791 ,bottom=886 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=1572 ,top=812 ,right=1683 ,bottom=849 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1572 ,top=849 ,right=1683 ,bottom=886 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݿ�����' ,left=1431 ,top=812 ,right=1558 ,bottom=849 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(������塤��' ,left=1434 ,top=849 ,right=1550 ,bottom=878 ,face='����' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�߱���� ����)' ,left=1434 ,top=878 ,right=1550 ,bottom=908 ,face='����' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī���' ,left=1304 ,top=812 ,right=1426 ,bottom=847 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(������塤��' ,left=1307 ,top=849 ,right=1423 ,bottom=878 ,face='����' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�߱���� ����)' ,left=1307 ,top=876 ,right=1423 ,bottom=905 ,face='����' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī��' ,left=1183 ,top=810 ,right=1289 ,bottom=849 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(������塤��' ,left=1177 ,top=849 ,right=1294 ,bottom=878 ,face='����' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�߱���� ����)' ,left=1177 ,top=878 ,right=1294 ,bottom=908 ,face='����' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1058 ,top=765 ,right=1156 ,bottom=889 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ƿ��' ,left=929 ,top=765 ,right=1024 ,bottom=892 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǰ���' ,left=667 ,top=818 ,right=765 ,bottom=855 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=664 ,top=863 ,right=770 ,bottom=900 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���强' ,left=802 ,top=831 ,right=892 ,bottom=876 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڷ�' ,left=585 ,top=778 ,right=651 ,bottom=818 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNO', left=1619, top=69, right=1786, bottom=111, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CNT', left=246, top=1000, right=294, bottom=1037, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_1', left=106, top=1050, right=164, bottom=1106, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_1', left=106, top=1117, right=164, bottom=1175, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_1', left=177, top=1050, right=341, bottom=1106, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF10_1,0,,REF10_1)}', left=651, top=915, right=781, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_S,0,,REF11_S)}', left=781, top=915, right=910, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_S,0,,REF12_S)}', left=910, top=915, right=1040, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_S,0,,REF13_S)}', left=1040, top=915, right=1169, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_S,0,,REF14_S)}', left=1169, top=915, right=1299, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_S,0,,REF15_S)}', left=1299, top=915, right=1429, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_S,0,,REF16_S)}', left=1429, top=915, right=1561, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_S,0,,REF17_S)}', left=1561, top=915, right=1691, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_S,0,,REF18_S)}', left=1691, top=915, right=1820, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_S,0,,REF19_S)}', left=1820, top=915, right=1950, bottom=966, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_S,0,,REF21_S)}', left=781, top=979, right=910, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_S,0,,REF22_S)}', left=910, top=979, right=1040, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_S,0,,REF23_S)}', left=1040, top=979, right=1169, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_S,0,,REF24_S)}', left=1169, top=979, right=1299, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_S,0,,REF25_S)}', left=1299, top=979, right=1429, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_S,0,,REF27_S)}', left=1561, top=979, right=1691, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_S,0,,REF28_S)}', left=1691, top=979, right=1820, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_S,0,,REF29_S)}', left=1820, top=979, right=1950, bottom=1035, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF10_1,0,,REF10_1)}', left=651, top=1050, right=781, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_1,0,,REF11_1)}', left=781, top=1050, right=910, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_1,0,,REF12_1)}', left=910, top=1050, right=1040, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_1,0,,REF13_1)}', left=1040, top=1050, right=1169, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_1,0,,REF14_1)}', left=1169, top=1050, right=1299, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_1,0,,REF15_1)}', left=1299, top=1050, right=1429, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_1,0,,REF16_1)}', left=1429, top=1050, right=1561, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_1,0,,REF17_1)}', left=1561, top=1050, right=1691, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_1,0,,REF18_1)}', left=1691, top=1050, right=1820, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_1,0,,REF19_1)}', left=1820, top=1050, right=1950, bottom=1109, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_1,0,,REF21_1)}', left=781, top=1117, right=910, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_1,0,,REF22_1)}', left=910, top=1117, right=1040, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_1,0,,REF23_1)}', left=1040, top=1117, right=1169, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_1,0,,REF24_1)}', left=1169, top=1117, right=1299, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_1,0,,REF25_1)}', left=1299, top=1117, right=1429, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_1,0,,REF27_1)}', left=1561, top=1117, right=1691, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_1,0,,REF28_1)}', left=1691, top=1117, right=1820, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_1,0,,REF29_1)}', left=1820, top=1117, right=1950, bottom=1175, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_2,0,,REF11_2)}', left=781, top=1185, right=910, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_2,0,,REF12_2)}', left=910, top=1185, right=1040, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_2,0,,REF13_2)}', left=1040, top=1185, right=1169, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_2,0,,REF14_2)}', left=1169, top=1185, right=1299, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_2,0,,REF15_2)}', left=1299, top=1185, right=1429, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_2,0,,REF16_2)}', left=1429, top=1185, right=1561, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_2,0,,REF17_2)}', left=1561, top=1185, right=1691, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_2,0,,REF18_2)}', left=1691, top=1185, right=1820, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_2,0,,REF19_2)}', left=1820, top=1185, right=1950, bottom=1246, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_2,0,,REF21_2)}', left=781, top=1254, right=910, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_2,0,,REF22_2)}', left=910, top=1254, right=1040, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_2,0,,REF23_2)}', left=1040, top=1254, right=1169, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_2,0,,REF24_2)}', left=1169, top=1254, right=1299, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_2,0,,REF25_2)}', left=1299, top=1254, right=1429, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_2,0,,REF27_2)}', left=1561, top=1254, right=1691, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_2,0,,REF28_2)}', left=1691, top=1254, right=1820, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_2,0,,REF29_2)}', left=1820, top=1254, right=1950, bottom=1315, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_3,0,,REF11_3)}', left=781, top=1326, right=910, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_3,0,,REF12_3)}', left=910, top=1326, right=1040, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_3,0,,REF13_3)}', left=1040, top=1326, right=1169, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_3,0,,REF14_3)}', left=1169, top=1326, right=1299, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_3,0,,REF15_3)}', left=1299, top=1326, right=1429, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_3,0,,REF16_3)}', left=1429, top=1326, right=1561, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_3,0,,REF17_3)}', left=1561, top=1326, right=1691, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_3,0,,REF18_3)}', left=1691, top=1326, right=1820, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_3,0,,REF19_3)}', left=1820, top=1326, right=1950, bottom=1384, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_3,0,,REF21_3)}', left=781, top=1394, right=910, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_3,0,,REF22_3)}', left=910, top=1394, right=1040, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_3,0,,REF23_3)}', left=1040, top=1394, right=1169, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_3,0,,REF24_3)}', left=1169, top=1394, right=1299, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_3,0,,REF25_3)}', left=1299, top=1394, right=1429, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_3,0,,REF27_3)}', left=1561, top=1394, right=1691, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_3,0,,REF28_3)}', left=1691, top=1394, right=1820, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_3,0,,REF29_3)}', left=1820, top=1394, right=1950, bottom=1455, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_4,0,,REF11_4)}', left=781, top=1466, right=910, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_4,0,,REF12_4)}', left=910, top=1466, right=1040, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_4,0,,REF13_4)}', left=1040, top=1466, right=1169, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_4,0,,REF14_4)}', left=1169, top=1466, right=1299, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_4,0,,REF15_4)}', left=1299, top=1466, right=1429, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_4,0,,REF16_4)}', left=1429, top=1466, right=1561, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_4,0,,REF17_4)}', left=1561, top=1466, right=1691, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_4,0,,REF18_4)}', left=1691, top=1466, right=1820, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_4,0,,REF19_4)}', left=1820, top=1466, right=1950, bottom=1524, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_4,0,,REF21_4)}', left=781, top=1535, right=910, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_4,0,,REF22_4)}', left=910, top=1535, right=1040, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_4,0,,REF23_4)}', left=1040, top=1535, right=1169, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_4,0,,REF24_4)}', left=1169, top=1535, right=1299, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_4,0,,REF25_4)}', left=1299, top=1535, right=1429, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_4,0,,REF27_4)}', left=1561, top=1535, right=1691, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_4,0,,REF28_4)}', left=1691, top=1535, right=1820, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_4,0,,REF29_4)}', left=1820, top=1535, right=1950, bottom=1595, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_5,0,,REF11_5)}', left=781, top=1606, right=910, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_5,0,,REF12_5)}', left=910, top=1606, right=1040, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_5,0,,REF13_5)}', left=1040, top=1606, right=1169, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_5,0,,REF14_5)}', left=1169, top=1606, right=1299, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_5,0,,REF15_5)}', left=1299, top=1606, right=1429, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_5,0,,REF16_5)}', left=1429, top=1606, right=1561, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_5,0,,REF17_5)}', left=1561, top=1606, right=1691, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_5,0,,REF18_5)}', left=1691, top=1606, right=1820, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_5,0,,REF19_5)}', left=1820, top=1606, right=1950, bottom=1664, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_5,0,,REF21_5)}', left=781, top=1675, right=910, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_5,0,,REF22_5)}', left=910, top=1675, right=1040, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_5,0,,REF23_5)}', left=1040, top=1675, right=1169, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_5,0,,REF24_5)}', left=1169, top=1675, right=1299, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_5,0,,REF25_5)}', left=1299, top=1675, right=1429, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_5,0,,REF27_5)}', left=1561, top=1675, right=1691, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_5,0,,REF28_5)}', left=1691, top=1675, right=1820, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_5,0,,REF29_5)}', left=1820, top=1675, right=1950, bottom=1736, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_6,0,,REF11_6)}', left=781, top=1746, right=910, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_6,0,,REF12_6)}', left=910, top=1746, right=1040, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_6,0,,REF13_6)}', left=1040, top=1746, right=1169, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_6,0,,REF14_6)}', left=1169, top=1746, right=1299, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_6,0,,REF15_6)}', left=1299, top=1746, right=1429, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_6,0,,REF16_6)}', left=1429, top=1746, right=1561, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_6,0,,REF17_6)}', left=1561, top=1746, right=1691, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_6,0,,REF18_6)}', left=1691, top=1746, right=1820, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_6,0,,REF19_6)}', left=1820, top=1746, right=1950, bottom=1804, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_6,0,,REF21_6)}', left=781, top=1815, right=910, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_6,0,,REF22_6)}', left=910, top=1815, right=1040, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_6,0,,REF23_6)}', left=1040, top=1815, right=1169, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_6,0,,REF24_6)}', left=1169, top=1815, right=1299, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_6,0,,REF25_6)}', left=1299, top=1815, right=1429, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_6,0,,REF27_6)}', left=1561, top=1815, right=1691, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_6,0,,REF28_6)}', left=1691, top=1815, right=1820, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_6,0,,REF29_6)}', left=1820, top=1815, right=1950, bottom=1876, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_7,0,,REF11_7)}', left=781, top=1884, right=910, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_7,0,,REF12_7)}', left=910, top=1884, right=1040, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_7,0,,REF13_7)}', left=1040, top=1884, right=1169, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_7,0,,REF14_7)}', left=1169, top=1884, right=1299, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_7,0,,REF15_7)}', left=1299, top=1884, right=1429, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_7,0,,REF16_7)}', left=1429, top=1884, right=1561, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_7,0,,REF17_7)}', left=1561, top=1884, right=1691, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_7,0,,REF18_7)}', left=1691, top=1884, right=1820, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_7,0,,REF19_7)}', left=1820, top=1884, right=1950, bottom=1945, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_8,0,,REF11_8)}', left=781, top=2024, right=910, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_8,0,,REF12_8)}', left=910, top=2024, right=1040, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_8,0,,REF13_8)}', left=1040, top=2024, right=1169, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_8,0,,REF14_8)}', left=1169, top=2024, right=1299, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_8,0,,REF15_8)}', left=1299, top=2024, right=1429, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_8,0,,REF16_8)}', left=1429, top=2024, right=1561, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_8,0,,REF17_8)}', left=1561, top=2024, right=1691, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_8,0,,REF18_8)}', left=1691, top=2024, right=1820, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_8,0,,REF19_8)}', left=1820, top=2024, right=1950, bottom=2085, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_8,0,,REF21_8)}', left=781, top=2096, right=910, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_8,0,,REF22_8)}', left=910, top=2096, right=1040, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_8,0,,REF23_8)}', left=1040, top=2096, right=1169, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_8,0,,REF24_8)}', left=1169, top=2096, right=1299, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_8,0,,REF25_8)}', left=1299, top=2096, right=1429, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_8,0,,REF27_8)}', left=1561, top=2096, right=1691, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_8,0,,REF28_8)}', left=1691, top=2096, right=1820, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_8,0,,REF29_8)}', left=1820, top=2096, right=1950, bottom=2154, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_2', left=106, top=1185, right=164, bottom=1244, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_2', left=106, top=1254, right=164, bottom=1312, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_2', left=177, top=1185, right=341, bottom=1244, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_3', left=106, top=1326, right=164, bottom=1386, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_3', left=106, top=1394, right=164, bottom=1458, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_3', left=177, top=1326, right=341, bottom=1386, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_4', left=106, top=1466, right=164, bottom=1524, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_4', left=106, top=1532, right=164, bottom=1598, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_4', left=177, top=1466, right=341, bottom=1524, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_5', left=106, top=1603, right=164, bottom=1664, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_5', left=106, top=1675, right=164, bottom=1736, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_6', left=106, top=1746, right=164, bottom=1804, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_6', left=106, top=1815, right=164, bottom=1876, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_6', left=177, top=1746, right=341, bottom=1804, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_7', left=106, top=1886, right=164, bottom=1945, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_7', left=106, top=1955, right=164, bottom=2016, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_7', left=177, top=1886, right=341, bottom=1945, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_8', left=106, top=2024, right=164, bottom=2088, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_8', left=106, top=2096, right=164, bottom=2154, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_8', left=177, top=2024, right=341, bottom=2088, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CLS_TAG', left=344, top=616, right=826, bottom=654, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_2', left=172, top=1251, right=347, bottom=1310 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_8', left=172, top=2096, right=347, bottom=2154 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=352 ,top=823 ,right=400 ,bottom=855 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=352 ,top=852 ,right=400 ,bottom=881 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=524 ,top=863 ,right=577 ,bottom=894 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6��' ,left=524 ,top=833 ,right=577 ,bottom=865 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=352 ,top=881 ,right=400 ,bottom=910 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=524 ,top=751 ,right=577 ,bottom=786 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ծ�' ,left=524 ,top=786 ,right=577 ,bottom=818 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=519 ,top=741 ,right=519 ,bottom=2159 </L>
	<T>id='�⺻' ,left=368 ,top=751 ,right=439 ,bottom=783 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=368 ,top=781 ,right=439 ,bottom=810 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=463 ,top=786 ,right=516 ,bottom=818 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=463 ,top=751 ,right=516 ,bottom=786 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=466 ,top=823 ,right=513 ,bottom=855 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=466 ,top=849 ,right=513 ,bottom=878 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=466 ,top=878 ,right=513 ,bottom=908 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=407 ,top=823 ,right=455 ,bottom=855 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=407 ,top=852 ,right=455 ,bottom=881 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=407 ,top=881 ,right=455 ,bottom=910 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='REF2_1', left=352, top=1050, right=452, bottom=1109, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_3', left=352, top=1326, right=452, bottom=1384, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_4', left=352, top=1466, right=452, bottom=1524, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_5', left=352, top=1606, right=452, bottom=1664, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_6', left=352, top=1746, right=452, bottom=1804, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_7', left=352, top=1884, right=452, bottom=1945, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_8', left=352, top=2024, right=452, bottom=2085, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=402 ,top=820 ,right=402 ,bottom=910 </L>
	<C>id='REF3_2', left=352, top=1251, right=402, bottom=1312, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=402 ,top=974 ,right=402 ,bottom=1042 </L>
	<C>id='REF3_1', left=352, top=1117, right=400, bottom=1175, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_1', left=407, top=1117, right=455, bottom=1175, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��Ÿ' ,left=582 ,top=1953 ,right=651 ,bottom=2013 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF29_7,0,,REF29_7)}', left=1820, top=1953, right=1950, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_7,0,,REF28_7)}', left=1691, top=1953, right=1820, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_7,0,,REF27_7)}', left=1561, top=1953, right=1691, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_7,0,,REF25_7)}', left=1299, top=1953, right=1429, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_7,0,,REF24_7)}', left=1169, top=1953, right=1299, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_7,0,,REF23_7)}', left=1040, top=1953, right=1169, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_7,0,,REF22_7)}', left=910, top=1953, right=1040, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_7,0,,REF21_7)}', left=781, top=1953, right=910, bottom=2013, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=402 ,top=1111 ,right=402 ,bottom=1180 </L>
	<L> left=405 ,top=2090 ,right=405 ,bottom=2159 </L>
	<C>id='REF2_2', left=352, top=1185, right=452, bottom=1246, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=407, top=1254, right=455, bottom=1312, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_7', left=352, top=1955, right=402, bottom=2016, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_7', left=407, top=1955, right=455, bottom=2016, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_8', left=352, top=2096, right=402, bottom=2154, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_8', left=407, top=2096, right=455, bottom=2154, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_3', left=172, top=1394, right=347, bottom=1458 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_3', left=352, top=1394, right=402, bottom=1455, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_3', left=407, top=1394, right=455, bottom=1453, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_4', left=172, top=1532, right=347, bottom=1598 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_4', left=352, top=1532, right=402, bottom=1593, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_4', left=407, top=1532, right=455, bottom=1590, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_5', left=177, top=1606, right=341, bottom=1667, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_5', left=172, top=1675, right=347, bottom=1736 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_5', left=352, top=1675, right=402, bottom=1736, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_5', left=407, top=1675, right=455, bottom=1733, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_6', left=172, top=1815, right=347, bottom=1876 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_6', left=352, top=1815, right=402, bottom=1876, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_6', left=407, top=1815, right=455, bottom=1873, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_7', left=172, top=1955, right=347, bottom=2016 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_8', left=460, top=2096, right=513, bottom=2154, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_8', left=460, top=2024, right=513, bottom=2082, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_7', left=460, top=1953, right=513, bottom=2011, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_7', left=460, top=1884, right=513, bottom=1942, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_6', left=460, top=1815, right=513, bottom=1873, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_6', left=460, top=1746, right=513, bottom=1804, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_5', left=460, top=1675, right=513, bottom=1733, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_5', left=460, top=1606, right=513, bottom=1664, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_4', left=460, top=1535, right=513, bottom=1593, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_4', left=460, top=1466, right=513, bottom=1524, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_3', left=460, top=1394, right=513, bottom=1453, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_3', left=460, top=1326, right=513, bottom=1384, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_2', left=460, top=1254, right=513, bottom=1312, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_2', left=460, top=1185, right=513, bottom=1244, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_1', left=460, top=1117, right=513, bottom=1175, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_1', left=460, top=1050, right=513, bottom=1109, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_1', left=524, top=1050, right=577, bottom=1109, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_1', left=524, top=1117, right=577, bottom=1175, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_2', left=524, top=1185, right=577, bottom=1244, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=524, top=1254, right=577, bottom=1312, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_3', left=524, top=1326, right=577, bottom=1384, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_3', left=524, top=1394, right=577, bottom=1453, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_4', left=524, top=1466, right=577, bottom=1524, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_4', left=524, top=1535, right=577, bottom=1593, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_5', left=524, top=1606, right=577, bottom=1664, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_5', left=524, top=1675, right=577, bottom=1733, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_6', left=524, top=1746, right=577, bottom=1804, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_6', left=524, top=1815, right=577, bottom=1873, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_7', left=524, top=1884, right=577, bottom=1942, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_7', left=524, top=1953, right=577, bottom=2011, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7_8', left=524, top=2024, right=577, bottom=2082, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_8', left=524, top=2096, right=577, bottom=2154, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ҵ桤���� �����Ű�/�ٷμҵ��� �ҵ桤���� �����Ű� (2015�� �ҵ濡 ���� ���������)' ,left=37 ,top=135 ,right=1934 ,bottom=206 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' �ٷμҵ� ���� ����� �ϰ� �ٷμҵ��ڿ��� ��� �ٷμҵ��õ¡���������� �߱��Ͽ��� �մϴ�.' ,left=37 ,top=243 ,right=1886 ,bottom=278 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' �������� �� �ٷμҵ��ڿ��� ȯ���� �߻��ϴ� ��� ��õ¡���ǹ��ڴ� �ٷμҵ��ڿ��� ȯ�޼����� �����ؾ� �մϴ�.' ,left=37 ,top=275 ,right=1886 ,bottom=310 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=310 ,right=1950 ,bottom=310 </L>
	<T>id='�ֹε�Ϲ�ȣ' ,left=849 ,top=310 ,right=1230 ,bottom=357 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=458, top=312, right=754, bottom=357, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=1341, top=310, right=1802, bottom=355, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=355 ,right=1950 ,bottom=355 </L>
	<T>id='�ҵ��� ����' ,left=29 ,top=310 ,right=339 ,bottom=355 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ�ó ��Ī' ,left=29 ,top=357 ,right=339 ,bottom=402 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��) ���� �ƻ�' ,left=447 ,top=357 ,right=759 ,bottom=402 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='221 - 81 - 13834' ,left=1228 ,top=357 ,right=1947 ,bottom=402 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=402 ,right=1950 ,bottom=402 </L>
	<T>id='������ ����' ,left=29 ,top=405 ,right=339 ,bottom=450 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HOL_YN', left=357, top=405, right=839, bottom=450, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='( ���� �ڵ� :  KR )' ,left=1400 ,top=405 ,right=1707 ,bottom=450 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=450 ,right=1950 ,bottom=450 </L>
	<T>id='�ٹ��Ⱓ' ,left=29 ,top=452 ,right=339 ,bottom=497 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WORKDAY', left=357, top=452, right=839, bottom=497, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=497 ,right=1950 ,bottom=497 </L>
	<T>id='������ �� , ������ڡ�' ,left=442 ,top=500 ,right=759 ,bottom=545 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �������� �ڵ� : KR )' ,left=1397 ,top=500 ,right=1725 ,bottom=545 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=545 ,right=1950 ,bottom=545 </L>
	<T>id='����ڵ�Ϲ�ȣ' ,left=849 ,top=357 ,right=1230 ,bottom=402 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=849 ,top=405 ,right=1230 ,bottom=450 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ⱓ' ,left=849 ,top=452 ,right=1230 ,bottom=497 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=849 ,top=500 ,right=1230 ,bottom=545 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=339 ,top=310 ,right=339 ,bottom=669 </L>
	<L> left=849 ,top=310 ,right=849 ,bottom=606 </L>
	<L> left=1230 ,top=310 ,right=1230 ,bottom=603 </L>
	<T>id='���ֱ���' ,left=29 ,top=500 ,right=339 ,bottom=545 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼 ��õ¡������' ,left=29 ,top=548 ,right=339 ,bottom=577 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����' ,left=29 ,top=640 ,right=339 ,bottom=669 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������û' ,left=29 ,top=577 ,right=339 ,bottom=606 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=606 ,right=1947 ,bottom=606 </L>
	<T>id='�� �������� �׸��� ����� ������ ��쿡�� �ֹε��ǥ��� �������� �ʽ��ϴ�.' ,left=855 ,top=611 ,right=1950 ,bottom=661 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �׸�' ,left=29 ,top=611 ,right=339 ,bottom=640 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�г���û ����' ,left=849 ,top=553 ,right=1230 ,bottom=598 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='INS_TAG', left=1328, top=558, right=1810, bottom=595, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LUN_CHK', left=347, top=558, right=839, bottom=595, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1820 ,top=741 ,right=1820 ,bottom=2159 </L>
	<T>id='( ������� ���а� ���߱������ ���Ե� �ݾ��� ���� ) �� �����ϴ�.' ,left=50 ,top=2768 ,right=1818 ,bottom=2797 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8. ����ī�� ������� ����������������������2���� ���� ����ī�� �� ������ Ư�����ѹ�����126��2��1����4ȣ�� �ش��ϴ� �ݾ� ' ,left=45 ,top=2741 ,right=1921 ,bottom=2770 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7. �����ܱ��� : ������ =1, �ܱ���=9 �� �����Ͽ� �����ϴ�. �ٷμҵ��ڰ� �ܱ��ο� �ش��ϴ� ��� ������ ������ �����ڵ�� ���������ڵ带  �����Ͽ� �����ϴ�.' ,left=45 ,top=2715 ,right=1921 ,bottom=2744 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=85 ,top=2709 ,right=1844 ,bottom=2709 </L>
	<L> left=1349 ,top=2619 ,right=1349 ,bottom=2709 </L>
	<L> left=262 ,top=2619 ,right=262 ,bottom=2709 </L>
	<T>id='3' ,left=1500 ,top=2680 ,right=1619 ,bottom=2709 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1844 ,top=2619 ,right=1844 ,bottom=2709 </L>
	<L> left=706 ,top=2619 ,right=706 ,bottom=2709 </L>
	<L> left=85 ,top=2619 ,right=85 ,bottom=2709 </L>
	<L> left=85 ,top=2675 ,right=1844 ,bottom=2675 </L>
	<T>id='�� ���� �׽� ġ�Ḧ ���ϴ� ����ȯ��' ,left=1357 ,top=2635 ,right=1839 ,bottom=2664 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������κ��������� ���� �����' ,left=267 ,top=2635 ,right=704 ,bottom=2667 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=90 ,top=2635 ,right=259 ,bottom=2664 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �̿� ������ �ڷμ� �ٷδɷ��� ���� ��' ,left=712 ,top=2648 ,right=1349 ,bottom=2675 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������������ �� ���� �� ������ ���� �������� ���� ' ,left=712 ,top=2622 ,right=1344 ,bottom=2648 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=85 ,top=2619 ,right=1847 ,bottom=2619 </L>
	<T>id=' 5. �γ��� ���������� �����ٷμҵ��� ���ο� �����Ͽ� �� ���뿩�θ� ǥ���մϴ�.' ,left=42 ,top=2564 ,right=1807 ,bottom=2593 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  - ��ο�� : 1945.12.31. ���� ��� ( �� 70�� �̻� : 100���� ���� ) ' ,left=82 ,top=2508 ,right=1942 ,bottom=2535 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. ���ɱ���' ,left=40 ,top=2479 ,right=1804 ,bottom=2508 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=966 ,top=2680 ,right=1085 ,bottom=2709 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=397 ,top=2680 ,right=516 ,bottom=2709 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ش��ڵ�' ,left=95 ,top=2680 ,right=257 ,bottom=2709 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 6. ����� ���������� ������ �ش� �ڵ带 �����ϴ�.' ,left=42 ,top=2593 ,right=1810 ,bottom=2619 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  - 6������ : 2010.01.01 ���� ��� ( �� 6�� ������ ��������ڰ� 2�� �̻��� ��� 1���� �ʰ��ϴ� 1��� �� 15���� ���װ��� )' ,left=82 ,top=2535 ,right=1942 ,bottom=2561 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �� �����ڵ� 4~6�� �ҵ��ڿ� ������� ������ ���踦 �����մϴ�.' ,left=87 ,top=2453 ,right=1849 ,bottom=2479 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     * �ش� �����Ӱ� �� ����ڰ� ������� ��� �� ����ڸ� ����' ,left=87 ,top=2424 ,right=1849 ,bottom=2453 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2418 ,right=1828 ,bottom=2418 </L>
	<T>id='�����ڸ�(�ҹ���50���)' ,left=87 ,top=2389 ,right=548 ,bottom=2418 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=548 ,top=2389 ,right=669 ,bottom=2418 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�ڵ�1~6����)(�ҹ���50��3��)' ,left=669 ,top=2389 ,right=1130 ,bottom=2418 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=1130 ,top=2389 ,right=1249 ,bottom=2418 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ź�Ƶ�(�ҹ���50��3��)' ,left=1249 ,top=2389 ,right=1709 ,bottom=2418 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=1709 ,top=2389 ,right=1828 ,bottom=2418 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2387 ,right=1828 ,bottom=2387 </L>
	<T>id='�����(�ҹ���50��2)' ,left=87 ,top=2357 ,right=548 ,bottom=2387 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=548 ,top=2357 ,right=669 ,bottom=2387 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�ڳࡤ�Ծ���)(�ҹ���50��3��)' ,left=669 ,top=2357 ,right=1130 ,bottom=2387 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4��' ,left=1130 ,top=2357 ,right=1249 ,bottom=2387 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�ڵ�4����)(�ҹ���50��3��)' ,left=1249 ,top=2357 ,right=1709 ,bottom=2387 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5��' ,left=1709 ,top=2357 ,right=1828 ,bottom=2387 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2355 ,right=1828 ,bottom=2355 </L>
	<T>id='�ҵ��� ����(�ҹ���50��1)' ,left=87 ,top=2326 ,right=548 ,bottom=2355 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='0' ,left=548 ,top=2326 ,right=669 ,bottom=2355 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ����� ��������(�ҹ���50��3��)' ,left=669 ,top=2326 ,right=1130 ,bottom=2355 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=1130 ,top=2326 ,right=1249 ,bottom=2355 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� ��������(�ҹ���50��3��)' ,left=1249 ,top=2326 ,right=1709 ,bottom=2355 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1709 ,top=2326 ,right=1828 ,bottom=2355 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2323 ,right=1828 ,bottom=2323 </L>
	<T>id='��  ��' ,left=87 ,top=2294 ,right=548 ,bottom=2323 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=548 ,top=2294 ,right=669 ,bottom=2323 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=669 ,top=2294 ,right=1130 ,bottom=2323 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=1130 ,top=2294 ,right=1249 ,bottom=2323 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1249 ,top=2294 ,right=1709 ,bottom=2323 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=1709 ,top=2294 ,right=1828 ,bottom=2323 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2291 ,right=1828 ,bottom=2291 </L>
	<L> left=87 ,top=2291 ,right=87 ,bottom=2418 </L>
	<L> left=545 ,top=2291 ,right=545 ,bottom=2418 </L>
	<L> left=669 ,top=2291 ,right=669 ,bottom=2418 </L>
	<L> left=1130 ,top=2291 ,right=1130 ,bottom=2418 </L>
	<L> left=1709 ,top=2291 ,right=1709 ,bottom=2418 </L>
	<L> left=1828 ,top=2291 ,right=1828 ,bottom=2418 </L>
	<L> left=1249 ,top=2294 ,right=1249 ,bottom=2421 </L>
	<T>id='  3. �����ڵ�' ,left=42 ,top=2265 ,right=1807 ,bottom=2294 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. �ҵ漼 ��õ¡������ ������û ������ �ҵ漼�� ����� �� 194����3�׿� ���� ��õ¡�������� ������ �����ϰ��� �ϴ� ��쿡 ���ϴ� �������� �� ǥ�� �մϴ�. ' ,left=42 ,top=2196 ,right=1807 ,bottom=2225 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. �г���û ���� ���� �ҵ漼�� ��137����4�׿� ���� �������� �߰� ���μ����� 10���� �ʰ��ϴ� ��쿡 �߰� ���������� �г���û ���θ� ǥ���մϴ�.' ,left=42 ,top=2230 ,right=1807 ,bottom=2260 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2712 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2799 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='210��x297��' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<L> left=29 ,top=103 ,right=1900 ,bottom=103 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=900 ,top=103 ,right=900 ,bottom=2799 </L>
	<L> left=1400 ,top=106 ,right=1400 ,bottom=2799 </L>
	<L> left=1601 ,top=103 ,right=1601 ,bottom=2799 </L>
	<L> left=29 ,top=103 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1902 ,top=103 ,right=1902 ,bottom=2794 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=101 ,top=164 ,right=101 ,bottom=2802 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��.' ,left=34 ,top=513 ,right=95 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=34 ,top=614 ,right=95 ,bottom=714 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=712 ,right=95 ,bottom=812 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1016 ,right=95 ,bottom=1114 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1111 ,right=95 ,bottom=1212 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=812 ,right=95 ,bottom=913 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=913 ,right=95 ,bottom=1013 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2350 ,right=95 ,bottom=2450 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2252 ,right=95 ,bottom=2352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2154 ,right=95 ,bottom=2254 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=2056 ,right=95 ,bottom=2156 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1860 ,right=95 ,bottom=1961 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1759 ,right=95 ,bottom=1860 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=1662 ,right=95 ,bottom=1762 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��.' ,left=34 ,top=1561 ,right=95 ,bottom=1662 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(2��)' ,left=1749 ,top=37 ,right=1902 ,bottom=98 ,align='right'</T>
	<L> left=1101 ,top=101 ,right=1101 ,bottom=2799 </L>
	<T>id='���Ա�' ,left=307 ,top=1082 ,right=394 ,bottom=1127 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=307 ,top=1037 ,right=394 ,bottom=1082 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=307 ,top=992 ,right=394 ,bottom=1037 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=307 ,top=947 ,right=394 ,bottom=992 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=1656 ,right=1902 ,bottom=1656 </L>
	<T>id='2013�� ���ڤ����ں�' ,left=357 ,top=1662 ,right=847 ,bottom=1707 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڤ����ڱݾ�' ,left=902 ,top=1662 ,right=1098 ,bottom=1707 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1662 ,right=1598 ,bottom=1707 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1709 ,right=1900 ,bottom=1709 </L>
	<C>id='{decode(VEN_AMT,0,,VEN_AMT)}', left=1117, top=1662, right=1397, bottom=1707, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=299 ,top=1762 ,right=1900 ,bottom=1762 </L>
	<T>id='2015�� ���� ���ڤ����ں�' ,left=357 ,top=1767 ,right=847 ,bottom=1812 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2014�� ���ڤ����ں�' ,left=357 ,top=1715 ,right=847 ,bottom=1759 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڤ����ڱݾ�' ,left=905 ,top=1715 ,right=1101 ,bottom=1759 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(VEN2_AMT,0,,VEN2_AMT)}', left=1117, top=1715, right=1397, bottom=1759, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1715 ,right=1598 ,bottom=1759 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڤ����ڱݾ�' ,left=905 ,top=1767 ,right=1101 ,bottom=1812 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(VEN3_AMT,0,,VEN3_AMT)}', left=1117, top=1767, right=1397, bottom=1812, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1767 ,right=1598 ,bottom=1812 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=302 ,top=1815 ,right=1902 ,bottom=1815 </L>
	<C>id='{decode(VEN_SUM,0,,VEN_SUM)}', left=1117, top=1820, right=1397, bottom=1865, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ڵ�' ,left=106 ,top=1762 ,right=296 ,bottom=1844 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=106 ,top=1677 ,right=296 ,bottom=1759 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=1868 ,right=1900 ,bottom=1868 </L>
	<X>left=900 ,top=1815 ,right=1101 ,bottom=1871 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�������� ���� �� �ҵ���� ��' ,left=357 ,top=1820 ,right=847 ,bottom=1865 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ſ�ī��(�����������߱������ ����)' ,left=307 ,top=1873 ,right=897 ,bottom=1918 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(CARD_AMT,0,,CARD_AMT)}', left=1117, top=1873, right=1397, bottom=1918, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=302 ,top=1921 ,right=1902 ,bottom=1921 </L>
	<L> left=299 ,top=1974 ,right=1900 ,bottom=1974 </L>
	<C>id='{decode(DIR_CARD_AMT,0,,DIR_CARD_AMT)}', left=1117, top=1926, right=1397, bottom=1971, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CASH_AMT,0,,CASH_AMT)}', left=1117, top=1979, right=1397, bottom=2024, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=302 ,top=2027 ,right=1902 ,bottom=2027 </L>
	<C>id='{decode(MARKET_AMT,0,,MARKET_AMT)}', left=1117, top=2032, right=1397, bottom=2077, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=299 ,top=2080 ,right=1900 ,bottom=2080 </L>
	<C>id='{decode(PUBLIC_AMT,0,,PUBLIC_AMT)}', left=1117, top=2085, right=1397, bottom=2130, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=299 ,top=2133 ,right=1902 ,bottom=2133 </L>
	<T>id='�� ���Ҥ�����ī��(�����������߱������ ����)' ,left=307 ,top=1926 ,right=897 ,bottom=1971 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���ݿ�����(�����������߱������ ����)' ,left=307 ,top=1979 ,right=897 ,bottom=2024 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����������' ,left=307 ,top=2032 ,right=897 ,bottom=2077 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���߱����̿��' ,left=307 ,top=2085 ,right=897 ,bottom=2130 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=2185 ,right=1902 ,bottom=2185 </L>
	<L> left=299 ,top=1447 ,right=299 ,bottom=2535 </L>
	<L> left=302 ,top=2236 ,right=1905 ,bottom=2236 </L>
	<T>id='�� ���� �ſ�ī������(2013��)' ,left=307 ,top=2191 ,right=897 ,bottom=2233 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=2286 ,right=1902 ,bottom=2286 </L>
	<L> left=299 ,top=2336 ,right=1902 ,bottom=2336 </L>
	<L> left=302 ,top=2387 ,right=1905 ,bottom=2387 </L>
	<L> left=299 ,top=2437 ,right=1902 ,bottom=2437 </L>
	<L> left=299 ,top=2487 ,right=1902 ,bottom=2487 </L>
	<L> left=106 ,top=2537 ,right=1905 ,bottom=2537 </L>
	<T>id='�� ���� �߰�����������(2013��)' ,left=307 ,top=2291 ,right=897 ,bottom=2334 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���� �߰�����������(2015�� ��ݱ�)' ,left=307 ,top=2342 ,right=897 ,bottom=2384 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���� �ſ�ī������(2015��)' ,left=307 ,top=2392 ,right=897 ,bottom=2434 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���� �߰�����������(2014��)' ,left=307 ,top=2442 ,right=897 ,bottom=2484 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���� �߰�����������(2015�� �Ϲݱ�)' ,left=307 ,top=2492 ,right=897 ,bottom=2535 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=1873 ,right=1101 ,bottom=1918 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=1926 ,right=1101 ,bottom=1971 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2085 ,right=1101 ,bottom=2130 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ſ�ī�� ��' ,left=106 ,top=2080 ,right=296 ,bottom=2162 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=106 ,top=2148 ,right=296 ,bottom=2230 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=1979 ,right=1101 ,bottom=2024 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2032 ,right=1101 ,bottom=2077 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=900 ,top=2133 ,right=1101 ,bottom=2185 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='���ݾ�' ,left=905 ,top=2191 ,right=1101 ,bottom=2233 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ���� �ſ�ī������(2014��)' ,left=307 ,top=2241 ,right=897 ,bottom=2283 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2241 ,right=1101 ,bottom=2283 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2291 ,right=1101 ,bottom=2334 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2342 ,right=1101 ,bottom=2384 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2392 ,right=1101 ,bottom=2434 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2442 ,right=1101 ,bottom=2484 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�' ,left=905 ,top=2492 ,right=1101 ,bottom=2535 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��( �� + �� + �� + �� + �� )' ,left=307 ,top=2138 ,right=897 ,bottom=2183 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(CARD_SUM,0,,CARD_SUM)}', left=1117, top=2138, right=1397, bottom=2183, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2013_AMT,0,,CARD_2013_AMT)}', left=1117, top=2191, right=1397, bottom=2233, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2014_AMT,0,,CARD_2014_AMT)}', left=1117, top=2241, right=1397, bottom=2283, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2015_SH_OVER,0,,CARD_2015_SH_OVER)}', left=1117, top=2492, right=1397, bottom=2535, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2014_OVER,0,,CARD_2014_OVER)}', left=1117, top=2442, right=1397, bottom=2484, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2015_AMT,0,,CARD_2015_AMT)}', left=1117, top=2392, right=1397, bottom=2434, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2015_FH_OVER,0,,CARD_2015_FH_OVER)}', left=1117, top=2342, right=1397, bottom=2384, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_2013_OVER,0,,CARD_2013_OVER)}', left=1117, top=2291, right=1397, bottom=2334, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=101 ,top=2731 ,right=1900 ,bottom=2731 </L>
	<L> left=101 ,top=2664 ,right=1900 ,bottom=2664 </L>
	<L> left=101 ,top=2601 ,right=1900 ,bottom=2601 </L>
	<T>id='�츮�������� �⿬��' ,left=235 ,top=2548 ,right=770 ,bottom=2590 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=905 ,top=2741 ,right=1101 ,bottom=2786 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڻ�ȯ��' ,left=905 ,top=2675 ,right=1101 ,bottom=2720 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱݻ谨��' ,left=905 ,top=2611 ,right=1101 ,bottom=2656 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⿬�ݾ�' ,left=905 ,top=2548 ,right=1101 ,bottom=2590 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LSS_AMT,0,,LSS_AMT)}', left=1117, top=2741, right=1397, bottom=2783, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=2741 ,right=1598 ,bottom=2789 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1408 ,top=2675 ,right=1601 ,bottom=2723 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1405 ,top=2611 ,right=1598 ,bottom=2659 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SAJU_AMT,0,,SAJU_AMT)}', left=1117, top=2548, right=1397, bottom=2590, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=2548 ,right=1598 ,bottom=2596 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1400 ,top=1818 ,right=1601 ,bottom=2537 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1871 ,right=1902 ,bottom=2135 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=2185 ,right=1902 ,bottom=2537 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��������߼ұ�� �ٷ���' ,left=235 ,top=2611 ,right=770 ,bottom=2656 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��� ���� ���ڻ�ȯ��' ,left=235 ,top=2675 ,right=770 ,bottom=2720 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������������������' ,left=235 ,top=2741 ,right=770 ,bottom=2786 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=1117 ,top=108 ,right=1381 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=53 ,top=108 ,right=275 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=349 ,top=108 ,right=860 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ⱸ��' ,left=918 ,top=108 ,right=1090 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ѵ���' ,left=1410 ,top=108 ,right=1588 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1617 ,top=108 ,right=1886 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=151 ,right=1900 ,bottom=151 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���ο��ݺ����' ,left=318 ,top=156 ,right=582 ,bottom=196 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=624 ,top=156 ,right=884 ,bottom=196 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=923 ,top=156 ,right=1090 ,bottom=196 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(JAQ_AMT,0,,JAQ_AMT)}', left=1119, top=156, right=1400, bottom=196, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1421 ,top=156 ,right=1590 ,bottom=196 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=603 ,top=198 ,right=1902 ,bottom=198 </L>
	<T>id='��(��)�ٹ���' ,left=627 ,top=204 ,right=886 ,bottom=243 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=923 ,top=204 ,right=1090 ,bottom=243 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(NPEN_AMT,0,,NPEN_AMT)}', left=1119, top=204, right=1400, bottom=243, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1421 ,top=204 ,right=1590 ,bottom=243 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=246 ,right=1900 ,bottom=246 </L>
	<T>id='��(��)�ٹ���' ,left=627 ,top=251 ,right=886 ,bottom=291 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=923 ,top=251 ,right=1090 ,bottom=291 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(JAR_AMT,0,,JAR_AMT)}', left=1119, top=251, right=1400, bottom=291, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1421 ,top=251 ,right=1590 ,bottom=291 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=294 ,right=1900 ,bottom=294 </L>
	<T>id='��(��)�ٹ���' ,left=627 ,top=299 ,right=886 ,bottom=339 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=921 ,top=299 ,right=1087 ,bottom=339 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1421 ,top=299 ,right=1590 ,bottom=339 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=341 ,right=299 ,bottom=341 </L>
	<T>id='�������ݺ����' ,left=323 ,top=296 ,right=585 ,bottom=336 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο��ݺ���� ����' ,left=310 ,top=254 ,right=595 ,bottom=294 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݺ���� ��' ,left=384 ,top=347 ,right=818 ,bottom=386 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PEN_SUM,0,,PEN_SUM)}', left=1117, top=347, right=1397, bottom=386, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��.' ,left=34 ,top=167 ,right=95 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݺ����' ,left=111 ,top=188 ,right=283 ,bottom=228 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���ο���,' ,left=111 ,top=228 ,right=283 ,bottom=267 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����������,' ,left=106 ,top=267 ,right=291 ,bottom=307 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���,' ,left=106 ,top=307 ,right=283 ,bottom=347 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������� ��)' ,left=106 ,top=347 ,right=294 ,bottom=386 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=34 ,top=206 ,right=95 ,bottom=246 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=34 ,top=246 ,right=95 ,bottom=286 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=286 ,right=95 ,bottom=325 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=34 ,top=325 ,right=95 ,bottom=365 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=389 ,right=1902 ,bottom=389 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<X>left=900 ,top=344 ,right=1101 ,bottom=389 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=344 ,right=1601 ,bottom=389 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��(��)�ٹ���' ,left=624 ,top=394 ,right=884 ,bottom=434 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=918 ,top=394 ,right=1085 ,bottom=434 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(JAH_AMT,0,,JAH_AMT)}', left=1117, top=394, right=1397, bottom=434, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1418 ,top=394 ,right=1588 ,bottom=434 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=598 ,top=437 ,right=1897 ,bottom=437 </L>
	<T>id='��(��)�ٹ���' ,left=624 ,top=442 ,right=884 ,bottom=482 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=915 ,top=442 ,right=1082 ,bottom=482 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HEALTH_AMT,0,,HEALTH_AMT)}', left=1117, top=442, right=1397, bottom=482, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1418 ,top=442 ,right=1588 ,bottom=482 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1900 ,top=484 ,right=302 ,bottom=484 </L>
	<T>id='���ΰǰ�����' ,left=328 ,top=400 ,right=548 ,bottom=439 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��������纸�� ����)' ,left=302 ,top=437 ,right=579 ,bottom=476 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ���' ,left=624 ,top=489 ,right=884 ,bottom=529 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=915 ,top=489 ,right=1082 ,bottom=529 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(JAP_AMT,0,,JAP_AMT)}', left=1117, top=489, right=1397, bottom=529, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1418 ,top=489 ,right=1588 ,bottom=529 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=598 ,top=532 ,right=1897 ,bottom=532 </L>
	<T>id='��(��)�ٹ���' ,left=624 ,top=537 ,right=884 ,bottom=577 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=915 ,top=537 ,right=1082 ,bottom=577 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HINS_AMT,0,,HINS_AMT)}', left=1117, top=537, right=1397, bottom=577, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1418 ,top=537 ,right=1588 ,bottom=577 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��뺸��' ,left=344 ,top=505 ,right=545 ,bottom=545 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=579 ,right=299 ,bottom=579 </L>
	<T>id='����� ��' ,left=463 ,top=585 ,right=736 ,bottom=624 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HIN_SUM,0,,HIN_SUM)}', left=1117, top=585, right=1397, bottom=624, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=119 ,top=431 ,right=283 ,bottom=611 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1400 ,top=579 ,right=1601 ,bottom=630 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=579 ,right=1101 ,bottom=630 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=101 ,top=630 ,right=1900 ,bottom=630 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����������' ,left=632 ,top=635 ,right=870 ,bottom=675 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LH1_AMT,0,,LH1_AMT)}', left=1117, top=635, right=1397, bottom=675, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1402 ,top=635 ,right=1595 ,bottom=675 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1103 ,top=677 ,right=1900 ,bottom=677 </L>
	<L> left=601 ,top=677 ,right=900 ,bottom=677 </L>
	<T>id='�����ݻ�ȯ��' ,left=913 ,top=667 ,right=1090 ,bottom=706 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ����' ,left=630 ,top=683 ,right=868 ,bottom=722 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LH2_AMT,0,,LH2_AMT)}', left=1117, top=683, right=1397, bottom=722, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����������Ա�' ,left=325 ,top=656 ,right=582 ,bottom=696 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=725 ,right=1900 ,bottom=725 </L>
	<T>id='�ۼ���� ����' ,left=1405 ,top=683 ,right=1598 ,bottom=722 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15�� �̸�' ,left=606 ,top=730 ,right=897 ,bottom=770 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LH4_AMT,0,,LH4_AMT)}', left=1117, top=730, right=1397, bottom=770, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=601 ,top=773 ,right=900 ,bottom=773 </L>
	<T>id='15��~29��' ,left=606 ,top=778 ,right=897 ,bottom=818 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=820 ,right=900 ,bottom=820 </L>
	<T>id='30�� �̻�' ,left=606 ,top=826 ,right=897 ,bottom=865 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=402 ,top=868 ,right=900 ,bottom=868 </L>
	<T>id='���Ժ�' ,left=410 ,top=796 ,right=598 ,bottom=836 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2011�� ����' ,left=410 ,top=751 ,right=598 ,bottom=791 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݸ� OR ���ġ' ,left=606 ,top=870 ,right=897 ,bottom=897 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=926 ,right=900 ,bottom=926 </L>
	<T>id='��Ÿ ����' ,left=606 ,top=931 ,right=897 ,bottom=971 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=402 ,top=971 ,right=900 ,bottom=971 </L>
	<T>id='2012�� ����' ,left=410 ,top=870 ,right=598 ,bottom=905 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ժ�' ,left=410 ,top=902 ,right=598 ,bottom=937 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(15���̻�)' ,left=410 ,top=937 ,right=598 ,bottom=971 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1103 ,top=773 ,right=1402 ,bottom=773 </L>
	<L> left=1601 ,top=773 ,right=1900 ,bottom=773 </L>
	<C>id='{decode(LH5_AMT,0,,LH5_AMT)}', left=1117, top=778, right=1397, bottom=818, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1103 ,top=820 ,right=1402 ,bottom=820 </L>
	<L> left=1601 ,top=820 ,right=1900 ,bottom=820 </L>
	<C>id='{decode(LH6_AMT,0,,LH6_AMT)}', left=1117, top=826, right=1397, bottom=865, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1103 ,top=868 ,right=1402 ,bottom=868 </L>
	<L> left=1103 ,top=926 ,right=1402 ,bottom=926 </L>
	<C>id='{decode(LH8_AMT,0,,LH8_AMT)}', left=1117, top=931, right=1397, bottom=971, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��ȯ ����' ,left=606 ,top=897 ,right=897 ,bottom=923 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LH7_AMT,0,,LH7_AMT)}', left=1117, top=878, right=1397, bottom=918, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1601 ,top=971 ,right=1900 ,bottom=971 </L>
	<L> left=1101 ,top=971 ,right=1400 ,bottom=971 </L>
	<T>id='��ȯ ����' ,left=696 ,top=1000 ,right=897 ,bottom=1027 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݸ� AND ���ġ' ,left=696 ,top=974 ,right=897 ,bottom=1000 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=691 ,top=1027 ,right=900 ,bottom=1027 </L>
	<T>id='��ȯ ����' ,left=696 ,top=1056 ,right=897 ,bottom=1082 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݸ� OR ���ġ' ,left=696 ,top=1029 ,right=897 ,bottom=1056 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=691 ,top=1082 ,right=900 ,bottom=1082 </L>
	<T>id='��Ÿ ����' ,left=696 ,top=1085 ,right=897 ,bottom=1124 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�̻�' ,left=616 ,top=1064 ,right=683 ,bottom=1098 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15��' ,left=616 ,top=1029 ,right=683 ,bottom=1064 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=1124 ,right=900 ,bottom=1124 </L>
	<L> left=1103 ,top=1027 ,right=1402 ,bottom=1027 </L>
	<C>id='{decode(LH9_AMT,0,,LH9_AMT)}', left=1117, top=979, right=1397, bottom=1019, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1101 ,top=1082 ,right=1400 ,bottom=1082 </L>
	<C>id='{decode(LH10_AMT,0,,LH10_AMT)}', left=1117, top=1035, right=1397, bottom=1074, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH11_AMT,0,,LH11_AMT)}', left=1117, top=1085, right=1397, bottom=1124, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1103 ,top=1124 ,right=1402 ,bottom=1124 </L>
	<T>id='��ȯ ����' ,left=696 ,top=1156 ,right=897 ,bottom=1183 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݸ� OR ���ġ' ,left=696 ,top=1130 ,right=897 ,bottom=1156 ,face='����' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14��' ,left=611 ,top=1154 ,right=677 ,bottom=1180 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10 ~' ,left=611 ,top=1130 ,right=677 ,bottom=1156 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1601 ,top=926 ,right=1900 ,bottom=926 </L>
	<L> left=1601 ,top=868 ,right=1900 ,bottom=868 </L>
	<L> left=1601 ,top=1027 ,right=1900 ,bottom=1027 </L>
	<L> left=1601 ,top=1082 ,right=1900 ,bottom=1082 </L>
	<L> left=1601 ,top=1124 ,right=1900 ,bottom=1124 </L>
	<T>id='���Ժ�' ,left=410 ,top=1080 ,right=598 ,bottom=1119 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2015�� ����' ,left=407 ,top=1035 ,right=595 ,bottom=1074 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1183 ,right=1900 ,bottom=1183 </L>
	<C>id='{decode(LH12_AMT,0,,LH12_AMT)}', left=1117, top=1135, right=1397, bottom=1175, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڱ� ������ ��' ,left=360 ,top=1188 ,right=828 ,bottom=1228 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=151 ,right=601 ,bottom=347 </L>
	<L> left=598 ,top=389 ,right=598 ,bottom=582 </L>
	<L> left=601 ,top=632 ,right=601 ,bottom=1185 </L>
	<L> left=400 ,top=728 ,right=400 ,bottom=1185 </L>
	<L> left=691 ,top=971 ,right=691 ,bottom=1183 </L>
	<X>left=900 ,top=1185 ,right=1601 ,bottom=1228 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='���ڻ�ȯ��' ,left=913 ,top=915 ,right=1090 ,bottom=955 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڱ�' ,left=119 ,top=786 ,right=278 ,bottom=1087 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=1228 ,right=1902 ,bottom=1228 </L>
	<T>id='���ø������� �ҵ���� ��' ,left=357 ,top=1614 ,right=847 ,bottom=1654 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ø�������' ,left=106 ,top=1476 ,right=296 ,bottom=1654 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LLL_SUM,0,,LLL_SUM)}', left=1117, top=1614, right=1397, bottom=1654, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=299 ,top=1609 ,right=1900 ,bottom=1609 </L>
	<X>left=1400 ,top=1609 ,right=1601 ,bottom=1656 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=1611 ,right=1101 ,bottom=1656 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='����û����������' ,left=357 ,top=1566 ,right=847 ,bottom=1606 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=910 ,top=1566 ,right=1093 ,bottom=1606 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LHP_AMT,0,,LHP_AMT)}', left=1117, top=1566, right=1397, bottom=1606, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1566 ,right=1598 ,bottom=1606 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1561 ,right=1900 ,bottom=1561 </L>
	<T>id='�ٷ������ø�������' ,left=357 ,top=1519 ,right=847 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=910 ,top=1519 ,right=1093 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LHR_AMT,0,,LHR_AMT)}', left=1117, top=1519, right=1397, bottom=1558, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1519 ,right=1598 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1513 ,right=1900 ,bottom=1513 </L>
	<T>id='û������' ,left=357 ,top=1471 ,right=847 ,bottom=1511 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=910 ,top=1471 ,right=1093 ,bottom=1511 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LHO_AMT,0,,LHO_AMT)}', left=1117, top=1471, right=1397, bottom=1511, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1471 ,right=1598 ,bottom=1511 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=1466 ,right=1900 ,bottom=1466 </L>
	<T>id='�ұ�����һ���� �����α�' ,left=249 ,top=1423 ,right=757 ,bottom=1463 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=910 ,top=1423 ,right=1093 ,bottom=1463 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1405 ,top=1423 ,right=1598 ,bottom=1463 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=1418 ,right=106 ,bottom=1418 </L>
	<T>id='���ο�������(2000�� ���� ����)' ,left=249 ,top=1376 ,right=757 ,bottom=1416 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=908 ,top=1376 ,right=1090 ,bottom=1416 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PER_AMT,0,,PER_AMT)}', left=1117, top=1376, right=1397, bottom=1416, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=1371 ,right=1902 ,bottom=1371 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=299 ,top=106 ,right=299 ,bottom=1373 </L>
	<T>id='(�̿���)' ,left=119 ,top=1302 ,right=278 ,bottom=1339 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=119 ,top=1262 ,right=278 ,bottom=1299 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������α�' ,left=307 ,top=1230 ,right=892 ,bottom=1262 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α��̿���(�հ�)' ,left=307 ,top=1336 ,right=892 ,bottom=1368 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ���� ����' ,left=1405 ,top=923 ,right=1598 ,bottom=963 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1262 ,right=1400 ,bottom=1262 </L>
	<T>id='������α�(������ü ��)' ,left=307 ,top=1265 ,right=892 ,bottom=1296 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1296 ,right=1400 ,bottom=1296 </L>
	<T>id='������α�(������ü)' ,left=307 ,top=1299 ,right=892 ,bottom=1331 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1331 ,right=1900 ,bottom=1331 </L>
	<T>id='��α��̿���' ,left=910 ,top=1230 ,right=1093 ,bottom=1262 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α��̿���' ,left=910 ,top=1265 ,right=1093 ,bottom=1296 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α��̿���' ,left=910 ,top=1299 ,right=1093 ,bottom=1331 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=900 ,top=1334 ,right=1101 ,bottom=1371 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=1334 ,right=1601 ,bottom=1371 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{decode(IW_LC1,0,,IW_LC1)}', left=1117, top=1230, right=1397, bottom=1262, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(IW_LC2,0,,IW_LC2)}', left=1117, top=1265, right=1397, bottom=1296, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(IW_LC3,0,,IW_LC3)}', left=1117, top=1299, right=1397, bottom=1331, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ���� ����' ,left=1402 ,top=1262 ,right=1595 ,bottom=1302 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>



</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='3��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2812 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='(3��)' ,left=1741 ,top=0 ,right=1894 ,bottom=42 ,align='right'</T>
	<T>id='      ������ ��û�� ��� �ش� ������ �����ؾ� �մϴ�.' ,left=1035 ,top=2463 ,right=1736 ,bottom=2495 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �����ؾ� �մϴ�.' ,left=921 ,top=2389 ,right=1622 ,bottom=2421 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� (    ) �� ���ݰ���, ���ø������� �� �ҵ�����װ����� ��û�� ���' ,left=908 ,top=2357 ,right=1844 ,bottom=2389 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� (    ) �� ������, ������ �� �����������Ա� ������ ��ȯ�� �ҵ������' ,left=908 ,top=2432 ,right=1894 ,bottom=2463 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1101 ,top=2270 ,right=1101 ,bottom=2355 </L>
	<T>id=' ���� ���� ����    ( O �Ǵ� X �� �����ϴ�)' ,left=90 ,top=2463 ,right=894 ,bottom=2490 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. �����פ������� �� �����������Ա� �����ݻ�ȯ�� �ҵ����' ,left=42 ,top=2432 ,right=894 ,bottom=2463 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� �Ƿ�����޸��� (   ),           �� ��αݸ��� (   ),          �� �ҵ������ ���� ��������' ,left=558 ,top=2503 ,right=1876 ,bottom=2540 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 5. �� ���� �߰� ���� ����' ,left=48 ,top=2500 ,right=468 ,bottom=2540 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. ���ݤ����� �� �ҵ���� ���� ���⿩��' ,left=42 ,top=2357 ,right=770 ,bottom=2394 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ( O �Ǵ� X �� �����ϴ�)' ,left=87 ,top=2397 ,right=556 ,bottom=2429 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��õ¡�������� ����(        )' ,left=1516 ,top=2307 ,right=1884 ,bottom=2350 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�ٹ��� �ٷμҵ�' ,left=1516 ,top=2273 ,right=1881 ,bottom=2310 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. ��(��)�ٹ�����' ,left=40 ,top=2273 ,right=294 ,bottom=2352 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڵ�Ϲ�ȣ' ,left=302 ,top=2315 ,right=540 ,bottom=2350 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)��������' ,left=908 ,top=2315 ,right=1095 ,bottom=2352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)�޿��Ѿ�' ,left=908 ,top=2273 ,right=1095 ,bottom=2307 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=296 ,top=2310 ,right=1498 ,bottom=2310 </L>
	<T>id='��(��)�ٹ�����' ,left=302 ,top=2273 ,right=537 ,bottom=2310 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� (        )' ,left=1566 ,top=2228 ,right=1860 ,bottom=2265 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. �ܱ��αٷ��� ���ϼ��������û�� ���� ����( O �Ǵ� X �� �����ϴ�)' ,left=42 ,top=2228 ,right=1193 ,bottom=2265 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=344 ,top=1537 ,right=437 ,bottom=1585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1701 ,top=392 ,right=1701 ,bottom=1693 </L>
	<T>id='������' ,left=344 ,top=1183 ,right=437 ,bottom=1230 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=243 ,top=1045 ,right=333 ,bottom=1090 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=243 ,top=987 ,right=333 ,bottom=1032 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��' ,left=243 ,top=926 ,right=333 ,bottom=971 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=243 ,top=566 ,right=333 ,bottom=611 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=243 ,top=503 ,right=333 ,bottom=548 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1344 ,top=392 ,right=1344 ,bottom=2008 </L>
	<L> left=238 ,top=48 ,right=238 ,bottom=2006 </L>
	<T>id='�Ű���' ,left=1085 ,top=2114 ,right=1326 ,bottom=2164 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ���' ,left=108 ,top=1106 ,right=230 ,bottom=1151 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=1217 ,right=98 ,bottom=1267 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=1140 ,right=98 ,bottom=1191 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=1064 ,right=98 ,bottom=1114 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=979 ,right=98 ,bottom=1029 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=902 ,right=98 ,bottom=953 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=828 ,right=98 ,bottom=876 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=37 ,top=751 ,right=98 ,bottom=802 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��.' ,left=37 ,top=675 ,right=98 ,bottom=725 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=50 ,right=29 ,bottom=2773 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='���װ����������' ,left=1151 ,top=56 ,right=1487 ,bottom=95 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=58 ,right=209 ,bottom=95 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ܱ���' ,left=243 ,top=146 ,right=333 ,bottom=191 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷ���' ,left=243 ,top=191 ,right=333 ,bottom=235 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ա�����' ,left=434 ,top=106 ,right=619 ,bottom=151 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ����������' ,left=384 ,top=56 ,right=720 ,bottom=95 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=796 ,top=53 ,right=796 ,bottom=103 </L>
	<T>id='210��x297��' ,left=1299 ,top=2778 ,right=1889 ,bottom=2813 ,align='right'</T>
	<T>id='     3. �����ݾ׶��� �ٷμҵ��ڰ� ��õ¡���ǹ��ڿ��� �����ϴ� ��� ���� ���� �� �ֽ��ϴ�.' ,left=40 ,top=2728 ,right=1900 ,bottom=2773 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. �� �ٹ����� ���ݺ��������ΰǰ������ �� ��뺸��� ���� �Ű����� �ۼ����� �ʾƵ� �˴ϴ�.' ,left=40 ,top=2683 ,right=1900 ,bottom=2728 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     �Ű����� ���� ��� ���꼼 �ΰ� �� �������� �����ϴ�.' ,left=40 ,top=2638 ,right=1900 ,bottom=2683 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. �ٷμҵ��ڰ� ��(��)�ٹ��� �ٷμҵ��� ��õ¡���ǹ��ڿ��� �Ű����� �ƴ��ϴ� ��쿡�� �ٷμҵ��� ������ ���ռҵ漼 �Ű� �Ͽ��� �ϸ�,' ,left=40 ,top=2593 ,right=1900 ,bottom=2638 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    �� ���ǻ���' ,left=40 ,top=2553 ,right=1900 ,bottom=2593 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1950 ,top=50 ,right=1950 ,bottom=2770 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=101 ,top=101 ,right=101 ,bottom=2000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=50 ,right=1950 ,bottom=50 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1953 ,top=101 ,right=26 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1564 ,top=392 ,right=1564 ,bottom=2006 </L>
	<L> left=1950 ,top=2773 ,right=29 ,bottom=2773 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2167 ,right=1950 ,bottom=2167 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=26 ,top=2006 ,right=1950 ,bottom=2006 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=2267 ,right=1947 ,bottom=2267 </L>
	<L> left=29 ,top=2352 ,right=1947 ,bottom=2352 </L>
	<L> left=32 ,top=2429 ,right=1947 ,bottom=2429 </L>
	<L> left=29 ,top=2543 ,right=1950 ,bottom=2543 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1945 ,top=2498 ,right=29 ,bottom=2498 </L>
	<L> left=545 ,top=2267 ,right=545 ,bottom=2352 </L>
	<L> left=29 ,top=2223 ,right=1953 ,bottom=2223 </L>
	<T>id='       �Ű����� ���ҵ漼���� ��140���� ���� ���� ������ �Ű��ϸ�, �� ������ ����� �����Ͽ��� �Ű����� �˰� �ִ� ��� �״�θ� ��Ȯ�ϰ� ' ,left=66 ,top=2011 ,right=1934 ,bottom=2058 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       �������� Ȯ���մϴ�.' ,left=66 ,top=2058 ,right=923 ,bottom=2098 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1569 ,top=2064 ,right=1625 ,bottom=2109 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 2016 ��   ' ,left=1365 ,top=2064 ,right=1487 ,bottom=2109 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MM', left=1490, top=2064, right=1566, bottom=2109, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DD', left=1625, top=2064, right=1701, bottom=2109, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=1701 ,top=2064 ,right=1757 ,bottom=2109 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �Ǵ� ��)' ,left=1603 ,top=2109 ,right=1884 ,bottom=2159 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=926 ,right=1701 ,bottom=926 </L>
	<T>id='��. �߰� ���� ����' ,left=37 ,top=2175 ,right=307 ,bottom=2220 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=524 ,top=2498 ,right=524 ,bottom=2540 </L>
	<C>id='EMPNMK', left=1344, top=2103, right=1588, bottom=2162, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���װ���' ,left=108 ,top=220 ,right=230 ,bottom=265 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1500 ,top=2223 ,right=1500 ,bottom=2270 </L>
	<L> left=344 ,top=153 ,right=1947 ,bottom=153 </L>
	<T>id='[ ] ���ΰ� ����   [ ] ������԰��   [ ] ������Ư�����ѹ����� ����   [ ] ��������� ����' ,left=699 ,top=106 ,right=1889 ,bottom=148 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������԰�� �Ǵ� �ٷ�������' ,left=370 ,top=159 ,right=773 ,bottom=204 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ⱓ ������' ,left=1064 ,top=159 ,right=1334 ,bottom=206 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=344 ,top=206 ,right=1945 ,bottom=206 </L>
	<T>id='������' ,left=1421 ,top=212 ,right=1622 ,bottom=257 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=833 ,top=212 ,right=1035 ,bottom=257 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ܱ��� �ٷμҵ濡 ���� ����' ,left=368 ,top=212 ,right=770 ,bottom=257 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=347 ,top=259 ,right=1945 ,bottom=259 </L>
	<T>id='�ٷμҵ濡 ���� �������� �� ����' ,left=352 ,top=265 ,right=799 ,bottom=310 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=833 ,top=265 ,right=1035 ,bottom=310 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1423 ,top=265 ,right=1625 ,bottom=310 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=238 ,top=312 ,right=1945 ,bottom=312 </L>
	<L> left=344 ,top=101 ,right=344 ,bottom=312 </L>
	<T>id='����Ⱓ ������' ,left=1389 ,top=318 ,right=1659 ,bottom=362 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=833 ,top=318 ,right=1035 ,bottom=362 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=98 ,top=365 ,right=1947 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=799 ,top=156 ,right=799 ,bottom=1998 </L>
	<L> left=1701 ,top=206 ,right=1701 ,bottom=384 </L>
	<T>id='�߼ұ�� ����� ����' ,left=296 ,top=318 ,right=733 ,bottom=362 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ��' ,left=294 ,top=370 ,right=730 ,bottom=415 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=873 ,top=370 ,right=1074 ,bottom=415 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ѵ���' ,left=1180 ,top=370 ,right=1339 ,bottom=415 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1363 ,top=370 ,right=1564 ,bottom=415 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1577 ,top=370 ,right=1693 ,bottom=415 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1720 ,top=370 ,right=1918 ,bottom=415 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1945 ,top=418 ,right=235 ,bottom=418 </L>
	<T>id='���б���ΰ���' ,left=368 ,top=423 ,right=738 ,bottom=468 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=336 ,top=471 ,right=1164 ,bottom=471 </L>
	<T>id='���Աݾ�' ,left=804 ,top=423 ,right=953 ,bottom=468 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ٷ��������޿� ���������' ,left=368 ,top=476 ,right=751 ,bottom=513 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1159 ,top=542 ,right=336 ,bottom=542 </L>
	<T>id='���Աݾ�' ,left=807 ,top=484 ,right=955 ,bottom=532 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Աݾ�' ,left=807 ,top=548 ,right=955 ,bottom=593 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ANN_AMT,0,,ANN_AMT)}', left=963, top=548, right=1162, bottom=593, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=336 ,top=595 ,right=1564 ,bottom=595 </L>
	<T>id='���� ��������' ,left=373 ,top=511 ,right=743 ,bottom=540 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=376 ,top=548 ,right=746 ,bottom=593 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݰ��� ��' ,left=376 ,top=601 ,right=746 ,bottom=646 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DCANN_SUM,0,,DCANN_SUM)}', left=963, top=601, right=1162, bottom=646, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=648 ,right=1947 ,bottom=648 </L>
	<X>left=799 ,top=595 ,right=958 ,bottom=651 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1162 ,top=595 ,right=1344 ,bottom=651 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='���强' ,left=542 ,top=654 ,right=691 ,bottom=699 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=818 ,top=654 ,right=942 ,bottom=699 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LIN_AMT,0,,LIN_AMT)}', left=963, top=654, right=1162, bottom=699, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='100����' ,left=1175 ,top=654 ,right=1334 ,bottom=699 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=818 ,top=706 ,right=942 ,bottom=751 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LIH_AMT,0,,LIH_AMT)}', left=963, top=706, right=1162, bottom=751, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='100����' ,left=1172 ,top=706 ,right=1331 ,bottom=751 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������뺸�强' ,left=505 ,top=706 ,right=751 ,bottom=751 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ��' ,left=503 ,top=759 ,right=743 ,bottom=804 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LI_SUM,0,,LI_SUM)}', left=963, top=759, right=1162, bottom=804, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=336 ,top=807 ,right=1947 ,bottom=807 </L>
	<X>left=799 ,top=754 ,right=958 ,bottom=807 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1162 ,top=754 ,right=1344 ,bottom=810 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='���Τ�65�� �̻��ڤ������' ,left=447 ,top=812 ,right=796 ,bottom=841 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ü���' ,left=447 ,top=841 ,right=796 ,bottom=870 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=815 ,top=818 ,right=939 ,bottom=865 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HEA_AMT,0,,HEA_AMT)}', left=963, top=818, right=1162, bottom=865, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=442 ,top=873 ,right=1162 ,bottom=873 </L>
	<T>id='�� ���� ���������' ,left=479 ,top=878 ,right=786 ,bottom=923 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=815 ,top=878 ,right=939 ,bottom=923 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(OHEA_AMT,0,,OHEA_AMT)}', left=963, top=878, right=1162, bottom=923, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1564 ,top=873 ,right=1344 ,bottom=873 </L>
	<L> left=1561 ,top=926 ,right=442 ,bottom=926 </L>
	<T>id='�Ƿ�� ��' ,left=476 ,top=931 ,right=788 ,bottom=976 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1180 ,top=868 ,right=1331 ,bottom=918 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ����' ,left=1180 ,top=818 ,right=1331 ,bottom=868 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HEA_SUM,0,,HEA_SUM)}', left=963, top=931, right=1162, bottom=976, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=336 ,top=979 ,right=1947 ,bottom=979 </L>
	<T>id='�Ƿ��' ,left=344 ,top=870 ,right=437 ,bottom=918 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ��� ����' ,left=476 ,top=984 ,right=783 ,bottom=1029 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GRA_AMT,0,,GRA_AMT)}', left=963, top=984, right=1162, bottom=1029, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1180 ,top=984 ,right=1331 ,bottom=1029 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(��' ,left=818 ,top=984 ,right=942 ,bottom=1008 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�п� ����)' ,left=818 ,top=1008 ,right=942 ,bottom=1032 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=1032 ,right=442 ,bottom=1032 </L>
	<T>id='�п��� ��' ,left=818 ,top=1061 ,right=942 ,bottom=1085 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ġ��/' ,left=818 ,top=1037 ,right=942 ,bottom=1061 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �Ƶ� ' ,left=452 ,top=1037 ,right=669 ,bottom=1082 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(EDU_AMT1,0,,EDU_AMT1)}', left=963, top=1037, right=1162, bottom=1082, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1��� 300����' ,left=1164 ,top=1037 ,right=1341 ,bottom=1082 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAG1_CNT', left=664, top=1037, right=796, bottom=1082, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1564 ,top=1085 ,right=442 ,bottom=1085 </L>
	<T>id='1��� 300����' ,left=1164 ,top=1090 ,right=1341 ,bottom=1135 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(EDU_AMT2,0,,EDU_AMT2)}', left=963, top=1090, right=1162, bottom=1135, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������' ,left=818 ,top=1090 ,right=942 ,bottom=1135 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAG2_CNT', left=664, top=1090, right=796, bottom=1135, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���߰���б� ' ,left=450 ,top=1090 ,right=667 ,bottom=1135 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1561 ,top=1138 ,right=442 ,bottom=1138 </L>
	<T>id='���л�(���п�������)' ,left=447 ,top=1143 ,right=685 ,bottom=1188 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAG3_CNT', left=683, top=1143, right=796, bottom=1188, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������' ,left=815 ,top=1143 ,right=939 ,bottom=1188 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(EDU_AMT3,0,,EDU_AMT3)}', left=963, top=1143, right=1159, bottom=1188, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1��� 900����' ,left=1164 ,top=1143 ,right=1341 ,bottom=1188 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1191 ,right=1564 ,bottom=1191 </L>
	<T>id='����� ' ,left=458 ,top=1196 ,right=675 ,bottom=1241 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAG4_CNT', left=664, top=1196, right=796, bottom=1241, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Ư��������' ,left=799 ,top=1196 ,right=953 ,bottom=1241 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HED_AMT,0,,HED_AMT)}', left=963, top=1196, right=1159, bottom=1241, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����' ,left=1177 ,top=1196 ,right=1328 ,bottom=1241 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=445 ,top=1244 ,right=1950 ,bottom=1244 </L>
	<L> left=1048 ,top=161 ,right=1048 ,bottom=206 </L>
	<T>id='������ ��' ,left=466 ,top=1249 ,right=778 ,bottom=1294 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(EDU_SUM,0,,EDU_SUM)}', left=966, top=1249, right=1162, bottom=1294, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=339 ,top=1296 ,right=1953 ,bottom=1296 </L>
	<X>left=799 ,top=1244 ,right=958 ,bottom=1299 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1162 ,top=1244 ,right=1344 ,bottom=1299 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=926 ,right=958 ,bottom=979 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1162 ,top=926 ,right=1344 ,bottom=979 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��ġ�ڱ�' ,left=447 ,top=1302 ,right=564 ,bottom=1344 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10���� ����' ,left=579 ,top=1302 ,right=786 ,bottom=1344 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=566 ,top=1344 ,right=1162 ,bottom=1344 </L>
	<T>id='10���� �ʰ�' ,left=579 ,top=1349 ,right=786 ,bottom=1392 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=458 ,top=1349 ,right=550 ,bottom=1392 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1394 ,right=1162 ,bottom=1394 </L>
	<L> left=566 ,top=1296 ,right=566 ,bottom=1394 </L>
	<T>id='������α�' ,left=450 ,top=1400 ,right=796 ,bottom=1442 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=804 ,top=1400 ,right=955 ,bottom=1442 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1445 ,right=1162 ,bottom=1445 </L>
	<T>id='�츮�������ձ�α�' ,left=450 ,top=1450 ,right=796 ,bottom=1492 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GOV1_AMT,0,,GOV1_AMT)}', left=966, top=1302, right=1162, bottom=1344, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��αݾ�' ,left=804 ,top=1302 ,right=955 ,bottom=1344 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=804 ,top=1349 ,right=955 ,bottom=1392 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GOV2_AMT,0,,GOV2_AMT)}', left=966, top=1349, right=1162, bottom=1392, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LC1_AMT,0,,LC1_AMT)}', left=966, top=1400, right=1162, bottom=1442, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��αݾ�' ,left=804 ,top=1450 ,right=955 ,bottom=1492 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1495 ,right=1162 ,bottom=1495 </L>
	<T>id='������α�(������ü��)' ,left=450 ,top=1500 ,right=796 ,bottom=1543 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=804 ,top=1500 ,right=955 ,bottom=1543 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1545 ,right=1162 ,bottom=1545 </L>
	<T>id='������α�(������ü' ,left=450 ,top=1550 ,right=796 ,bottom=1593 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��αݾ�' ,left=804 ,top=1550 ,right=955 ,bottom=1593 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α� ��' ,left=450 ,top=1601 ,right=796 ,bottom=1643 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=1646 ,right=238 ,bottom=1646 </L>
	<X>left=799 ,top=1595 ,right=958 ,bottom=1646 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1162 ,top=1595 ,right=1344 ,bottom=1646 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1344 ,top=156 ,right=1344 ,bottom=384 </L>
	<L> left=336 ,top=421 ,right=336 ,bottom=1648 </L>
	<L> left=442 ,top=651 ,right=442 ,bottom=1646 </L>
	<L> left=958 ,top=421 ,right=958 ,bottom=1648 </L>
	<L> left=1162 ,top=368 ,right=1162 ,bottom=1646 </L>
	<T>id='���ܿ�õ�ҵ�' ,left=807 ,top=1651 ,right=995 ,bottom=1688 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=802 ,top=1691 ,right=1902 ,bottom=1691 </L>
	<T>id='������(��ȭ)' ,left=807 ,top=1696 ,right=995 ,bottom=1733 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(��ȭ)' ,left=807 ,top=1741 ,right=995 ,bottom=1778 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=802 ,top=1781 ,right=1947 ,bottom=1781 </L>
	<T>id='��������' ,left=807 ,top=1786 ,right=995 ,bottom=1823 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=802 ,top=1826 ,right=1947 ,bottom=1826 </L>
	<T>id='��û��������' ,left=807 ,top=1831 ,right=995 ,bottom=1868 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=802 ,top=1871 ,right=1950 ,bottom=1871 </L>
	<T>id='�ٹ��Ⱓ' ,left=807 ,top=1876 ,right=995 ,bottom=1913 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=241 ,top=1916 ,right=1950 ,bottom=1916 </L>
	<T>id='�ܱ����μ���' ,left=355 ,top=1696 ,right=691 ,bottom=1865 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڱ����Ա����ڼ��װ���' ,left=294 ,top=1921 ,right=751 ,bottom=1958 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=238 ,top=1961 ,right=1947 ,bottom=1961 </L>
	<T>id='������ ���װ���' ,left=294 ,top=1966 ,right=751 ,bottom=2003 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1000 ,top=1648 ,right=1000 ,bottom=2008 </L>
	<T>id='���ڻ�ȯ��' ,left=807 ,top=1921 ,right=995 ,bottom=1958 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=804 ,top=1736 ,right=1950 ,bottom=1736 </L>
	<X>left=1344 ,top=1646 ,right=1947 ,bottom=1736 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='-' ,left=1357 ,top=1741 ,right=1550 ,bottom=1778 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1357 ,top=1786 ,right=1550 ,bottom=1823 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ܱٹ�ó' ,left=1357 ,top=1831 ,right=1550 ,bottom=1868 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��å' ,left=1357 ,top=1876 ,right=1550 ,bottom=1913 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30%' ,left=1357 ,top=1921 ,right=1550 ,bottom=1958 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10%' ,left=1357 ,top=1966 ,right=1550 ,bottom=2003 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1177 ,top=503 ,right=1336 ,bottom=553 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ����' ,left=1180 ,top=452 ,right=1331 ,bottom=503 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=471 ,right=1344 ,bottom=471 </L>
	<L> left=1947 ,top=471 ,right=1701 ,bottom=471 </L>
	<T>id='12%' ,left=1577 ,top=466 ,right=1693 ,bottom=516 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ǵ�' ,left=1577 ,top=516 ,right=1693 ,bottom=566 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15%' ,left=1577 ,top=566 ,right=1693 ,bottom=616 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=595 ,right=1701 ,bottom=595 </L>
	<L> left=1564 ,top=542 ,right=1347 ,bottom=542 </L>
	<L> left=1950 ,top=542 ,right=1704 ,bottom=542 </L>
	<T>id='�����' ,left=344 ,top=706 ,right=434 ,bottom=754 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12%' ,left=1577 ,top=654 ,right=1693 ,bottom=699 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15%' ,left=1577 ,top=706 ,right=1693 ,bottom=751 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=701 ,right=1950 ,bottom=701 </L>
	<L> left=442 ,top=754 ,right=1950 ,bottom=754 </L>
	<L> left=1701 ,top=873 ,right=1950 ,bottom=873 </L>
	<T>id='15%' ,left=1577 ,top=868 ,right=1693 ,bottom=918 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15%' ,left=1577 ,top=1103 ,right=1693 ,bottom=1154 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=1032 ,right=1701 ,bottom=1032 </L>
	<L> left=1947 ,top=1085 ,right=1701 ,bottom=1085 </L>
	<L> left=1947 ,top=1138 ,right=1701 ,bottom=1138 </L>
	<L> left=1947 ,top=1191 ,right=1701 ,bottom=1191 </L>
	<T>id='100/110' ,left=1574 ,top=1302 ,right=1691 ,bottom=1344 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=1344 ,right=1344 ,bottom=1344 </L>
	<L> left=1564 ,top=1394 ,right=1347 ,bottom=1394 </L>
	<L> left=442 ,top=1595 ,right=1564 ,bottom=1595 </L>
	<L> left=1564 ,top=1445 ,right=1347 ,bottom=1445 </L>
	<L> left=1564 ,top=1495 ,right=1344 ,bottom=1495 </L>
	<L> left=1947 ,top=1394 ,right=1701 ,bottom=1394 </L>
	<L> left=1950 ,top=1445 ,right=1704 ,bottom=1445 </L>
	<L> left=1950 ,top=1495 ,right=1704 ,bottom=1495 </L>
	<L> left=1564 ,top=1545 ,right=1344 ,bottom=1545 </L>
	<L> left=1947 ,top=1545 ,right=1701 ,bottom=1545 </L>
	<L> left=1947 ,top=1595 ,right=1701 ,bottom=1595 </L>
	<T>id='15%' ,left=1572 ,top=1431 ,right=1688 ,bottom=1482 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(25%)' ,left=1572 ,top=1482 ,right=1688 ,bottom=1532 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ۼ����' ,left=1180 ,top=1405 ,right=1331 ,bottom=1447 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1180 ,top=1447 ,right=1331 ,bottom=1490 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=296 ,top=2270 ,right=296 ,bottom=2355 </L>
	<L> left=892 ,top=2270 ,right=892 ,bottom=2429 </L>
	<C>id='{decode(LH3_AMT,0,,LH3_AMT)}', left=1021, top=1966, right=1328, bottom=2003, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=807 ,top=1966 ,right=995 ,bottom=2003 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LC4_AMT,0,,LC4_AMT)}', left=966, top=1453, right=1162, bottom=1495, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LC2_AMT,0,,LC2_AMT)}', left=966, top=1500, right=1162, bottom=1543, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LC3_AMT,0,,LC3_AMT)}', left=966, top=1550, right=1162, bottom=1593, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LCC_SUM,0,,LCC_SUM)}', left=966, top=1601, right=1162, bottom=1643, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DCIRP_AMT,0,,DCIRP_AMT)}', left=963, top=487, right=1162, bottom=532, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=180
<R>id='7��.sbt' ,left=0 ,top=20 ,right=2000 ,bottom=151, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='����' ,size=10 ,penwidth=1
	<L> left=82 ,top=130 ,right=1953 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=82 ,top=2799 ,right=1953 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=82 ,top=130 ,right=82 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1953 ,top=130 ,right=1953 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=82 ,top=249 ,right=1953 ,bottom=249 </L>
	<L> left=82 ,top=349 ,right=1953 ,bottom=349 </L>
	<L> left=82 ,top=431 ,right=1953 ,bottom=431 </L>
	<L> left=82 ,top=511 ,right=1953 ,bottom=511 </L>
	<L> left=802 ,top=349 ,right=802 ,bottom=511 </L>
	<L> left=1281 ,top=349 ,right=1281 ,bottom=511 </L>
	<L> left=1336 ,top=349 ,right=1336 ,bottom=431 </L>
	<L> left=1392 ,top=349 ,right=1392 ,bottom=431 </L>
	<L> left=1450 ,top=349 ,right=1450 ,bottom=431 </L>
	<L> left=1505 ,top=349 ,right=1505 ,bottom=431 </L>
	<L> left=1561 ,top=349 ,right=1561 ,bottom=431 </L>
	<L> left=1617 ,top=349 ,right=1617 ,bottom=431 </L>
	<L> left=1672 ,top=349 ,right=1672 ,bottom=431 </L>
	<L> left=1728 ,top=349 ,right=1728 ,bottom=431 </L>
	<L> left=1786 ,top=349 ,right=1786 ,bottom=431 </L>
	<L> left=1842 ,top=349 ,right=1842 ,bottom=431 </L>
	<L> left=1897 ,top=349 ,right=1897 ,bottom=431 </L>
	<C>id='EMPNMK', left=352, top=431, right=802, bottom=511</C>
	<T>id='(7��)' ,left=1791 ,top=71 ,right=1945 ,bottom=132 ,align='right'</T>
	<T>id='1. ��������' ,left=103 ,top=249 ,right=352 ,bottom=349 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���            ȣ' ,left=82 ,top=349 ,right=352 ,bottom=431 ,align='left'</T>
	<T>id='����ƻ� �ֽ�ȸ��' ,left=352 ,top=349 ,right=802 ,bottom=431</T>
	<T>id='���  ��  ��  ��  ��  ��  ȣ' ,left=802 ,top=349 ,right=1281 ,bottom=431 ,align='left'</T>
	<T>id='2' ,left=1281 ,top=349 ,right=1336 ,bottom=431</T>
	<T>id='2' ,left=1336 ,top=349 ,right=1392 ,bottom=431</T>
	<T>id='1' ,left=1392 ,top=349 ,right=1450 ,bottom=431</T>
	<T>id='-' ,left=1450 ,top=349 ,right=1505 ,bottom=431</T>
	<T>id='8' ,left=1505 ,top=349 ,right=1561 ,bottom=431</T>
	<T>id='1' ,left=1561 ,top=349 ,right=1617 ,bottom=431</T>
	<T>id='-' ,left=1617 ,top=349 ,right=1672 ,bottom=431</T>
	<T>id='1' ,left=1672 ,top=349 ,right=1728 ,bottom=431</T>
	<T>id='3' ,left=1728 ,top=349 ,right=1786 ,bottom=431</T>
	<T>id='8' ,left=1786 ,top=349 ,right=1842 ,bottom=431</T>
	<T>id='3' ,left=1842 ,top=349 ,right=1897 ,bottom=431</T>
	<T>id='4' ,left=1897 ,top=349 ,right=1953 ,bottom=431</T>
	<T>id='�鼺            ��' ,left=82 ,top=431 ,right=352 ,bottom=511 ,align='left'</T>
	<T>id='����   ��   ��   ��   ��   ȣ' ,left=802 ,top=431 ,right=1281 ,bottom=511 ,align='left'</T>
	<T>id='5. �����ݾ׶��� �ٷμҵ��ڰ� ���� �ƴ��� �� �ֽ��ϴ�.' ,left=93 ,top=2731 ,right=1953 ,bottom=2781 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210��x297��' ,left=1352 ,top=2805 ,right=1942 ,bottom=2839 ,align='right'</T>
	<T>id='4. ���ø������� ������ ���౸�ж��� û������, ����û���������� �� �ٷ������ø����������� �����Ͽ� �����ϴ�.' ,left=93 ,top=2683 ,right=1953 ,bottom=2733 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. ����������¿��� �������౸�ж��� ���ο�������� ������������ �����Ͽ� �����ϴ�.' ,left=93 ,top=2633 ,right=1953 ,bottom=2683 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. �������ݰ��¿��� �������ݱ��ж��� ��������(DC, IRP), ���б���ΰ���ȸ�� �����Ͽ� �����ϴ�.' ,left=93 ,top=2582 ,right=1953 ,bottom=2633 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' �ۼ��Ͽ��� �մϴ�. �ش� ���º��� ���Աݾװ� �ҵ�,���� �����ݾ��� ����, �����ݾ��� 0�� ��쿡�� ���� �ʽ��ϴ�.' ,left=93 ,top=2532 ,right=1953 ,bottom=2582 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. ���ݰ��� ���װ���, ���ø������ࡤ������������������� �ҵ������ �޴� �ҵ��ڿ� ���ؼ��� �ش� �ҵ�, ���װ����� ���� ����' ,left=93 ,top=2482 ,right=1953 ,bottom=2532 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ۼ����' ,left=93 ,top=2434 ,right=1953 ,bottom=2482 ,align='left'</T>
	<L> left=82 ,top=2424 ,right=1953 ,bottom=2424 </L>
	<T>id='�ҵ�����ݾ�' ,left=1654 ,top=2122 ,right=1953 ,bottom=2183</T>
	<T>id='���Աݾ�' ,left=1352 ,top=2122 ,right=1654 ,bottom=2183</T>
	<T>id='���¹�ȣ' ,left=945 ,top=2122 ,right=1344 ,bottom=2183</T>
	<T>id='����ȸ�� ��' ,left=214 ,top=2122 ,right=786 ,bottom=2183</T>
	<T>id='     * ������������������� �ҵ������ ���� ���� �ۼ��մϴ�.' ,left=93 ,top=2072 ,right=1153 ,bottom=2122 ,align='left'</T>
	<T>id='���װ����ݾ�' ,left=1654 ,top=1664 ,right=1953 ,bottom=1722</T>
	<T>id='���Աݾ�' ,left=1352 ,top=1664 ,right=1654 ,bottom=1722</T>
	<T>id='���¹�ȣ' ,left=902 ,top=1664 ,right=1352 ,bottom=1722</T>
	<T>id='����ȸ�� ��' ,left=352 ,top=1664 ,right=902 ,bottom=1722</T>
	<T>id='���� ����' ,left=82 ,top=1664 ,right=352 ,bottom=1722</T>
	<T>id='     * ���ø������� �ҵ������ ���� ���� �ۼ��մϴ�.' ,left=93 ,top=1614 ,right=1053 ,bottom=1664 ,align='left'</T>
	<T>id='3. ���ø������� �ҵ����' ,left=103 ,top=1564 ,right=553 ,bottom=1614 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT4_4,0,,DEDAMT4_4)}', left=1654, top=2363, right=1953, bottom=2424, align='right'</C>
	<C>id='{decode(PAYAMT4_4,0,,PAYAMT4_4)}', left=1352, top=2363, right=1654, bottom=2424, align='right'</C>
	<C>id='{decode(DEDAMT4_3,0,,DEDAMT4_3)}', left=1654, top=2302, right=1953, bottom=2363, align='right'</C>
	<C>id='{decode(PAYAMT4_3,0,,PAYAMT4_3)}', left=1352, top=2302, right=1654, bottom=2363, align='right'</C>
	<C>id='{decode(DEDAMT4_2,0,,DEDAMT4_2)}', left=1654, top=2244, right=1953, bottom=2302, align='right'</C>
	<C>id='{decode(PAYAMT4_2,0,,PAYAMT4_2)}', left=1352, top=2244, right=1654, bottom=2302, align='right'</C>
	<C>id='{decode(DEDAMT4_1,0,,DEDAMT4_1)}', left=1654, top=2183, right=1953, bottom=2244, align='right'</C>
	<C>id='{decode(PAYAMT4_1,0,,PAYAMT4_1)}', left=1352, top=2183, right=1654, bottom=2244, align='right'</C>
	<C>id='{decode(DEDAMT3_5,0,,DEDAMT3_5)}', left=1654, top=1963, right=1953, bottom=2024, align='right'</C>
	<C>id='{decode(PAYAMT3_5,0,,PAYAMT3_5)}', left=1352, top=1963, right=1654, bottom=2024, align='right'</C>
	<C>id='ACCNO3_5', left=902, top=1963, right=1352, bottom=2024</C>
	<C>id='FINANM3_5', left=352, top=1963, right=902, bottom=2024, align='left'</C>
	<C>id='DUDGBNM3_5', left=82, top=1963, right=352, bottom=2024</C>
	<C>id='{decode(DEDAMT3_4,0,,DEDAMT3_4)}', left=1654, top=1902, right=1953, bottom=1963, align='right'</C>
	<C>id='{decode(PAYAMT3_4,0,,PAYAMT3_4)}', left=1352, top=1902, right=1654, bottom=1963, align='right'</C>
	<C>id='ACCNO3_4', left=902, top=1902, right=1352, bottom=1963</C>
	<C>id='FINANM3_4', left=352, top=1902, right=902, bottom=1963, align='left'</C>
	<C>id='DUDGBNM3_4', left=82, top=1902, right=352, bottom=1963</C>
	<C>id='{decode(DEDAMT3_3,0,,DEDAMT3_3)}', left=1654, top=1844, right=1953, bottom=1902, align='right'</C>
	<C>id='{decode(PAYAMT3_3,0,,PAYAMT3_3)}', left=1352, top=1844, right=1654, bottom=1902, align='right'</C>
	<C>id='ACCNO3_3', left=902, top=1844, right=1352, bottom=1902</C>
	<C>id='FINANM3_3', left=352, top=1844, right=902, bottom=1902, align='left'</C>
	<C>id='DUDGBNM3_3', left=82, top=1844, right=352, bottom=1902</C>
	<C>id='{decode(DEDAMT3_2,0,,DEDAMT3_2)}', left=1654, top=1783, right=1953, bottom=1844, align='right'</C>
	<C>id='{decode(PAYAMT3_2,0,,PAYAMT3_2)}', left=1352, top=1783, right=1654, bottom=1844, align='right'</C>
	<C>id='ACCNO3_2', left=902, top=1783, right=1352, bottom=1844</C>
	<C>id='FINANM3_2', left=352, top=1783, right=902, bottom=1844, align='left'</C>
	<C>id='DUDGBNM3_2', left=82, top=1783, right=352, bottom=1844</C>
	<C>id='{decode(DEDAMT3_1,0,,DEDAMT3_1)}', left=1654, top=1722, right=1953, bottom=1783, align='right'</C>
	<C>id='{decode(PAYAMT3_1,0,,PAYAMT3_1)}', left=1352, top=1722, right=1654, bottom=1783, align='right'</C>
	<C>id='ACCNO3_1', left=902, top=1722, right=1352, bottom=1783</C>
	<C>id='FINANM3_1', left=352, top=1722, right=902, bottom=1783, align='left'</C>
	<C>id='DUDGBNM3_1', left=82, top=1722, right=352, bottom=1783</C>
	<C>id='{decode(DEDAMT2_5,0,,DEDAMT2_5)}', left=1654, top=1503, right=1953, bottom=1564, align='right'</C>
	<C>id='{decode(PAYAMT2_5,0,,PAYAMT2_5)}', left=1352, top=1503, right=1654, bottom=1564, align='right'</C>
	<C>id='ACCNO2_5', left=902, top=1503, right=1352, bottom=1564</C>
	<C>id='FINANM2_5', left=352, top=1503, right=902, bottom=1564, align='left'</C>
	<C>id='DUDGBNM2_5', left=82, top=1503, right=352, bottom=1564</C>
	<L> left=1654 ,top=2122 ,right=1654 ,bottom=2424 </L>
	<L> left=1654 ,top=1664 ,right=1654 ,bottom=2024 </L>
	<L> left=1352 ,top=2122 ,right=1352 ,bottom=2424 </L>
	<L> left=1352 ,top=1664 ,right=1352 ,bottom=2024 </L>
	<L> left=902 ,top=1664 ,right=902 ,bottom=2024 </L>
	<L> left=352 ,top=1664 ,right=352 ,bottom=2024 </L>
	<L> left=82 ,top=2363 ,right=1953 ,bottom=2363 </L>
	<L> left=82 ,top=2302 ,right=1953 ,bottom=2302 </L>
	<L> left=82 ,top=2244 ,right=1953 ,bottom=2244 </L>
	<L> left=82 ,top=2183 ,right=1953 ,bottom=2183 </L>
	<L> left=82 ,top=2122 ,right=1953 ,bottom=2122 </L>
	<L> left=82 ,top=2024 ,right=1953 ,bottom=2024 </L>
	<L> left=82 ,top=1963 ,right=1953 ,bottom=1963 </L>
	<L> left=82 ,top=1902 ,right=1953 ,bottom=1902 </L>
	<L> left=82 ,top=1844 ,right=1953 ,bottom=1844 </L>
	<L> left=82 ,top=1783 ,right=1953 ,bottom=1783 </L>
	<L> left=82 ,top=1722 ,right=1953 ,bottom=1722 </L>
	<L> left=82 ,top=1664 ,right=1953 ,bottom=1664 </L>
	<L> left=82 ,top=1564 ,right=1953 ,bottom=1564 </L>
	<T>id='���װ����ݾ�' ,left=1654 ,top=1204 ,right=1953 ,bottom=1262</T>
	<T>id='���Աݾ�' ,left=1352 ,top=1204 ,right=1654 ,bottom=1262</T>
	<T>id='���¹�ȣ' ,left=902 ,top=1204 ,right=1352 ,bottom=1262</T>
	<T>id='����ȸ�� ��' ,left=352 ,top=1204 ,right=902 ,bottom=1262</T>
	<T>id='�������౸��' ,left=82 ,top=1204 ,right=352 ,bottom=1262</T>
	<T>id='     * ����������¿� ���� ���� �ۼ��մϴ�.' ,left=93 ,top=1154 ,right=953 ,bottom=1204 ,align='left'</T>
	<T>id='2) �����������' ,left=103 ,top=1103 ,right=452 ,bottom=1154 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ����ݾ�' ,left=1654 ,top=863 ,right=1953 ,bottom=923</T>
	<T>id='���Աݾ�' ,left=1352 ,top=863 ,right=1654 ,bottom=923</T>
	<T>id='���¹�ȣ' ,left=902 ,top=863 ,right=1352 ,bottom=923</T>
	<T>id='����ȸ�� ��' ,left=352 ,top=863 ,right=902 ,bottom=923</T>
	<T>id='�������ݱ���' ,left=82 ,top=863 ,right=352 ,bottom=923</T>
	<T>id='     * �������ݰ��¿� ���� ���� �ۼ��մϴ�.' ,left=93 ,top=812 ,right=953 ,bottom=863 ,align='left'</T>
	<T>id='1) �������ݰ���' ,left=103 ,top=762 ,right=452 ,bottom=812 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT2_4,0,,DEDAMT2_4)}', left=1654, top=1442, right=1953, bottom=1503, align='right'</C>
	<C>id='{decode(PAYAMT2_4,0,,PAYAMT2_4)}', left=1352, top=1442, right=1654, bottom=1503, align='right'</C>
	<C>id='ACCNO2_4', left=902, top=1442, right=1352, bottom=1503</C>
	<C>id='FINANM2_4', left=352, top=1442, right=902, bottom=1503, align='left'</C>
	<C>id='DUDGBNM2_4', left=82, top=1442, right=352, bottom=1503</C>
	<C>id='{decode(DEDAMT2_3,0,,DEDAMT2_3)}', left=1654, top=1384, right=1953, bottom=1442, align='right'</C>
	<C>id='{decode(PAYAMT2_3,0,,PAYAMT2_3)}', left=1352, top=1384, right=1654, bottom=1442, align='right'</C>
	<C>id='ACCNO2_3', left=902, top=1384, right=1352, bottom=1442</C>
	<C>id='FINANM2_3', left=352, top=1384, right=902, bottom=1442, align='left'</C>
	<C>id='DUDGBNM2_3', left=82, top=1384, right=352, bottom=1442</C>
	<C>id='{decode(DEDAMT2_2,0,,DEDAMT2_2)}', left=1654, top=1323, right=1953, bottom=1384, align='right'</C>
	<C>id='{decode(PAYAMT2_2,0,,PAYAMT2_2)}', left=1352, top=1323, right=1654, bottom=1384, align='right'</C>
	<C>id='ACCNO2_2', left=902, top=1323, right=1352, bottom=1384</C>
	<C>id='FINANM2_2', left=352, top=1323, right=902, bottom=1384, align='left'</C>
	<C>id='DUDGBNM2_2', left=82, top=1323, right=352, bottom=1384</C>
	<C>id='{decode(DEDAMT2_1,0,,DEDAMT2_1)}', left=1654, top=1262, right=1953, bottom=1323, align='right'</C>
	<C>id='{decode(PAYAMT2_1,0,,PAYAMT2_1)}', left=1352, top=1262, right=1654, bottom=1323, align='right'</C>
	<C>id='ACCNO2_1', left=902, top=1262, right=1352, bottom=1323</C>
	<C>id='FINANM2_1', left=352, top=1262, right=902, bottom=1323, align='left'</C>
	<C>id='DUDGBNM2_1', left=82, top=1262, right=352, bottom=1323</C>
	<C>id='{decode(DEDAMT1_3,0,,DEDAMT1_3)}', left=1654, top=1042, right=1953, bottom=1103, align='right'</C>
	<C>id='{decode(PAYAMT1_3,0,,PAYAMT1_3)}', left=1352, top=1042, right=1654, bottom=1103, align='right'</C>
	<C>id='ACCNO1_3', left=902, top=1042, right=1352, bottom=1103</C>
	<C>id='FINANM1_3', left=352, top=1042, right=902, bottom=1103, align='left'</C>
	<C>id='DUDGBNM1_3', left=82, top=1042, right=352, bottom=1103</C>
	<C>id='{decode(DEDAMT1_2,0,,DEDAMT1_2)}', left=1654, top=982, right=1953, bottom=1042, align='right'</C>
	<C>id='{decode(PAYAMT1_2,0,,PAYAMT1_2)}', left=1352, top=982, right=1654, bottom=1042, align='right'</C>
	<C>id='ACCNO1_2', left=902, top=982, right=1352, bottom=1042</C>
	<C>id='FINANM1_2', left=352, top=982, right=902, bottom=1042, align='left'</C>
	<C>id='DUDGBNM1_2', left=82, top=982, right=352, bottom=1042</C>
	<C>id='{decode(DEDAMT1_1,0,,DEDAMT1_1)}', left=1654, top=923, right=1953, bottom=982, align='right'</C>
	<C>id='{decode(PAYAMT1_1,0,,PAYAMT1_1)}', left=1352, top=923, right=1654, bottom=982, align='right'</C>
	<C>id='ACCNO1_1', left=902, top=923, right=1352, bottom=982</C>
	<C>id='FINANM1_1', left=352, top=923, right=902, bottom=982, align='left'</C>
	<C>id='DUDGBNM1_1', left=82, top=923, right=352, bottom=982</C>
	<L> left=902 ,top=863 ,right=902 ,bottom=1103 </L>
	<L> left=352 ,top=863 ,right=352 ,bottom=1103 </L>
	<L> left=82 ,top=1503 ,right=1953 ,bottom=1503 </L>
	<L> left=82 ,top=1442 ,right=1953 ,bottom=1442 </L>
	<L> left=82 ,top=1384 ,right=1953 ,bottom=1384 </L>
	<L> left=82 ,top=1323 ,right=1953 ,bottom=1323 </L>
	<L> left=82 ,top=1262 ,right=1953 ,bottom=1262 </L>
	<L> left=82 ,top=1204 ,right=1953 ,bottom=1204 </L>
	<L> left=82 ,top=1103 ,right=1953 ,bottom=1103 </L>
	<L> left=82 ,top=1042 ,right=1953 ,bottom=1042 </L>
	<L> left=82 ,top=982 ,right=1953 ,bottom=982 </L>
	<L> left=82 ,top=923 ,right=1953 ,bottom=923 </L>
	<L> left=82 ,top=863 ,right=1953 ,bottom=863 </L>
	<L> left=1352 ,top=1204 ,right=1352 ,bottom=1564 </L>
	<T>id='����            ��' ,left=82 ,top=511 ,right=352 ,bottom=590 ,align='left'</T>
	<T>id='(��ȭ��ȣ:' ,left=1453 ,top=511 ,right=1622 ,bottom=590 ,align='left'</T>
	<C>id='TELNO', left=1617, top=511, right=1905, bottom=590, align='left'</C>
	<T>id=')' ,left=1892 ,top=511 ,right=1924 ,bottom=590 ,align='left'</T>
	<L> left=82 ,top=593 ,right=1953 ,bottom=593 </L>
	<T>id='�����������' ,left=82 ,top=593 ,right=352 ,bottom=675 ,align='left'</T>
	<T>id=' ���� ���α� ������ 1-7 ����׷����' ,left=360 ,top=601 ,right=1003 ,bottom=669 ,align='left'</T>
	<L> left=82 ,top=675 ,right=1953 ,bottom=675 </L>
	<T>id='( ��ȭ��ȣ:02-3669-3700    )' ,left=1463 ,top=601 ,right=1945 ,bottom=667 ,align='left'</T>
	<L> left=352 ,top=349 ,right=352 ,bottom=677 </L>
	<T>id='2. ���ݰ��� ���װ���' ,left=90 ,top=683 ,right=781 ,bottom=749 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. ������������������� �ҵ����' ,left=103 ,top=2024 ,right=815 ,bottom=2072 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1352 ,top=863 ,right=1352 ,bottom=1101 </L>
	<C>id='ADDRESS', left=362, top=516, right=1447, bottom=590, align='left'</C>
	<L> left=1654 ,top=863 ,right=1654 ,bottom=1103 </L>
	<C>id='EMPJUNO', left=1318, top=439, right=1926, bottom=503</C>
	<T>id='���� �� ���� �� �ҵ桤���װ��� ����' ,left=82 ,top=135 ,right=1953 ,bottom=238 ,face='���� ���' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=902 ,top=2122 ,right=902 ,bottom=2424 </L>
	<C>id='FINANM4_2', left=82, top=2244, right=897, bottom=2302</C>
	<C>id='FINANM4_4', left=82, top=2363, right=897, bottom=2424</C>
	<C>id='FINANM4_3', left=82, top=2302, right=897, bottom=2363</C>
	<C>id='FINANM4_1', left=82, top=2183, right=897, bottom=2244</C>
	<C>id='ACCNO4_1', left=913, top=2183, right=1344, bottom=2244</C>
	<C>id='ACCNO4_2', left=913, top=2244, right=1344, bottom=2302</C>
	<C>id='ACCNO4_3', left=915, top=2302, right=1344, bottom=2363</C>
	<C>id='ACCNO4_4', left=915, top=2363, right=1344, bottom=2424</C>
	<L> left=352 ,top=1204 ,right=352 ,bottom=1564 </L>
	<L> left=1654 ,top=1204 ,right=1654 ,bottom=1564 </L>
	<L> left=902 ,top=1204 ,right=902 ,bottom=1564 </L>
</B>


</R>
</A>


























">
</OBJECT>




<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_AC_RETACC"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_RETACC">
	<Param Name="BindInfo"
		, Value='
        <C>Col=DFM_CNT          Ctrl=txtDFM_CNT             Param=value     </C>
        <C>Col=GOL_CNT70        Ctrl=txtGOL_CNT70           Param=value     </C>
        <C>Col=GOL_CNT65        Ctrl=txtGOL_CNT65           Param=value     </C>
        <C>Col=TRB_CNT          Ctrl=txtTRB_CNT             Param=value     </C>
        <C>Col=RCH_CNT          Ctrl=txtRCH_CNT             Param=value     </C>
        <C>Col=CHI_CNT          Ctrl=txtCHI_CNT             Param=value     </C>
        <C>Col=INP_CNT          Ctrl=txtINP_CNT             Param=value     </C>
        <C>Col=INP_AMT          Ctrl=txtINP_AMT             Param=text      </C>        
        <C>Col=NPEN_AMT         Ctrl=txtNPEN_AMT            Param=text      </C>
        <C>Col=EPEN_AMT         Ctrl=txtEPEN_AMT            Param=text      </C>
        <C>Col=HINU_AMT         Ctrl=txtHINU_AMT            Param=text      </C>
        <C>Col=HINS_AMT         Ctrl=txtHINS_AMT            Param=text      </C>
        <C>Col=LIN_AMT          Ctrl=txtLIN_AMT             Param=text      </C>
        <C>Col=LIH_AMT          Ctrl=txtLIH_AMT             Param=text      </C>
        
        <C>Col=MHEA_AMT         Ctrl=txtMHEA_AMT            Param=text      </C>
        <C>Col=OHEA_AMT         Ctrl=txtOHEA_AMT            Param=text      </C>
        <C>Col=LF2_AMT          Ctrl=txtLF2_AMT             Param=text      </C>
        
        <C>Col=LEN_AMT          Ctrl=txtLEN_AMT             Param=text      </C>
        <C>Col=LEN_AMT2         Ctrl=txtLEN_AMT2            Param=text      </C>
        <C>Col=LEN_AMT3         Ctrl=txtLEN_AMT3            Param=text      </C>
        <C>Col=LEN_AMT4         Ctrl=txtLEN_AMT4            Param=text      </C>
        <C>Col=LEN_AMT5         Ctrl=txtLEN_AMT5            Param=text      </C>
        <C>Col=GRA_AMT          Ctrl=txtGRA_AMT             Param=text      </C>
        <C>Col=EDU_TAG1         Ctrl=cmbEDU_TAG1            Param=value     </C>
        <C>Col=EDU_TAG2         Ctrl=cmbEDU_TAG2            Param=value      </C>
        <C>Col=EDU_TAG3         Ctrl=cmbEDU_TAG3            Param=value      </C>
        <C>Col=EDU_TAG4         Ctrl=cmbEDU_TAG4            Param=value      </C>
        <C>Col=EDU_TAG5         Ctrl=cmbEDU_TAG5            Param=value      </C>
        <C>Col=EDU_AMT1         Ctrl=txtEDU_AMT1            Param=text      </C>
        <C>Col=EDU_AMT2         Ctrl=txtEDU_AMT2            Param=text      </C>
        <C>Col=EDU_AMT3         Ctrl=txtEDU_AMT3            Param=text      </C>
        <C>Col=EDU_AMT4         Ctrl=txtEDU_AMT4            Param=text      </C>
        <C>Col=EDU_AMT5         Ctrl=txtEDU_AMT5            Param=text      </C>
        <C>Col=HED_AMT          Ctrl=txtHED_AMT             Param=text      </C>
        
        <C>Col=LHO_AMT          Ctrl=txtLHO_AMT             Param=text      </C>
        <C>Col=LHP_AMT          Ctrl=txtLHP_AMT             Param=text      </C>
        <C>Col=LHQ_AMT          Ctrl=txtLHQ_AMT             Param=text      </C>
        <C>Col=LHR_AMT          Ctrl=txtLHR_AMT             Param=text      </C>
        
        <C>Col=LH1_AMT          Ctrl=txtLH1_AMT             Param=text      </C>
        <C>Col=LH2_AMT          Ctrl=txtLH2_AMT             Param=text      </C>
        <C>Col=LH3_AMT          Ctrl=txtLH3_AMT             Param=text      </C>        
        <C>Col=LH4_AMT          Ctrl=txtLH4_AMT             Param=text      </C>
        <C>Col=LH5_AMT          Ctrl=txtLH5_AMT             Param=text      </C>
        <C>Col=LH6_AMT          Ctrl=txtLH6_AMT             Param=text      </C>
        <C>Col=LH7_AMT          Ctrl=txtLH7_AMT             Param=text      </C>
        <C>Col=LH8_AMT          Ctrl=txtLH8_AMT             Param=text      </C>    
        <C>Col=LH9_AMT          Ctrl=txtLH9_AMT             Param=text      </C>    
        <C>Col=LH10_AMT         Ctrl=txtLH10_AMT             Param=text      </C>    
        <C>Col=LH11_AMT         Ctrl=txtLH11_AMT             Param=text      </C>    
        <C>Col=LH12_AMT         Ctrl=txtLH12_AMT             Param=text      </C>        

        <C>Col=GOV_AMT          	Ctrl=txtGOV_AMT             	Param=text      </C>
        <C>Col=LC1_AMT          	Ctrl=txtLC1_AMT             		Param=text      </C>
        <C>Col=LC2_AMT          	Ctrl=txtLC2_AMT             		Param=text      </C>
        <C>Col=LC3_AMT          	Ctrl=txtLC3_AMT            	 	Param=text      </C>
        <C>Col=LC4_AMT          	Ctrl=txtLC4_AMT             		Param=text      </C>                

        <C>Col=GOV_NTS          	Ctrl=txtGOV_NTS             		Param=text      </C>
        <C>Col=LC1_NTS          	Ctrl=txtLC1_NTS             		Param=text      </C>
        <C>Col=LC2_NTS          	Ctrl=txtLC2_NTS             		Param=text      </C>
        <C>Col=LC3_NTS          	Ctrl=txtLC3_NTS             		Param=text      </C>        
        <C>Col=GOV_DED          	Ctrl=txtGOV_DED             		Param=text      </C>

        <C>Col=FUN_CNT          	Ctrl=txtFUN_CNT             		Param=value     </C>
        <C>Col=LF1_AMT          	Ctrl=txtLF1_AMT             		Param=text      </C>
        <C>Col=VEN2_AMT         	Ctrl=txtVEN2_AMT            	Param=text      </C>
        
        <C>Col=CARD_AMT         	Ctrl=txtCARD_AMT            	Param=text      </C>
        <C>Col=DIR_CARD_AMT    	Ctrl=txtDIR_CARD_AMT        	Param=text      </C>
        <C>Col=CASH_AMT         	Ctrl=txtCASH_AMT            	Param=text      </C>
        <C>Col=MARKET_AMT      	Ctrl=txtMARKET_AMT        	Param=text      </C>   
        <C>Col=PUBLIC_AMT         Ctrl=txtPUBLIC_AMT            	Param=text      </C>
           
        <C>Col=LST_AMT          	Ctrl=txtLST_AMT             		Param=text      </C>

        <C>Col=PAYO_SUM         	Ctrl=txtPAYO_SUM            	Param=text      </C>
        <C>Col=LSQ_AMT          	Ctrl=txtLSQ_AMT             		Param=text      </C>

        <C>Col=WEL_CARD         	Ctrl=txtWEL_CARD            	Param=text      </C>
        <C>Col=CLS_TAG         		Ctrl=chkCLS_TAG            		Param=value     </C>

        <C>Col=SALT_AMT        		Ctrl=txtSALT_AMT           		Param=text      </C>
        <C>Col=FREE_INCOME       	Ctrl=txtFREE_INCOME          	Param=text      </C>        
        <C>Col=TAX_INCOME       		Ctrl=txtTAX_INCOME          	Param=text      </C>
        <C>Col=INCM_TAX        		Ctrl=txtINCM_TAX           		Param=text      </C>
        <C>Col=CITI_TAX     			Ctrl=txtCITI_TAX        			Param=text      </C>
        <C>Col=OLD_MED_AMT      	Ctrl=txtOLD_MED_AMT         	Param=text      </C>
        <C>Col=OLD_AMT          		Ctrl=txtOLD_AMT             		Param=text      </C>
       
        '>
</object>


<object id="bndT_CM_PERSON"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_CM_PERSON">
	<Param Name="BindInfo"
		, Value='
        <C>Col=OCC_NM          Ctrl=txtOCC_NM             Param=value     </C>
        <C>Col=DPT_NM          Ctrl=txtDPT_NM             Param=value     </C>
        <C>Col=JOB_NM          Ctrl=txtJOB_NM             Param=value     </C>
        <C>Col=CET_NO          Ctrl=txtCET_NO             Param=value     </C>
        <C>Col=ZIP_NO          Ctrl=txtZIP_NO             Param=value     </C>
        <C>Col=ADDRESS         Ctrl=txtADDRESS            Param=value     </C>
        <C>Col=ADR_CT          Ctrl=txtADR_CT             Param=value     </C>
        <C>Col=ENO_NO          Ctrl=txtENO_NO             Param=value     </C>
        <C>Col=HEAD_CD         Ctrl=txtHEAD_CD            Param=value     </C>
        <C>Col=DPT_CD          Ctrl=txtDPT_CD             Param=value     </C>
    '>
</object>